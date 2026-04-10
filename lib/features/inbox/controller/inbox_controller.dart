import 'dart:io';

import 'package:boat_sells_app/core/di/injection.dart';
import 'package:boat_sells_app/core/service/datasource/local/local_service.dart';
import 'package:boat_sells_app/core/service/datasource/remote/api_client.dart';
import 'package:boat_sells_app/core/service/datasource/remote/socket_service.dart';
import 'package:boat_sells_app/features/chat/model/chat_model.dart';
import 'package:boat_sells_app/features/inbox/model/inbox_model.dart';
import 'package:boat_sells_app/helper/toast/toast_helper.dart';
import 'package:boat_sells_app/utils/api_urls/api_urls.dart';
import 'package:boat_sells_app/utils/multipart/multipart_body.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class InboxController extends GetxController {
  final ApiClient apiClient = sl<ApiClient>();
  final LocalService localService = sl();

  final Rx<InboxMessageModel> inboxModel = InboxMessageModel().obs;
  final RxBool isBlocked = false.obs;
  final RxBool isBlockedByOther = false.obs;
  final RxBool isBlockLoading = false.obs;

  /// Reactive header info – set via [initWith].
  final RxString avatarUrl = ''.obs;
  final RxString userName = 'Unknown'.obs;

  /// The other participant's ID and role – used as `receiverId` when sending.
  final RxString receiverId = ''.obs;
  final RxString receiverRole = 'USER'.obs;

  bool isLoading = false;

  /// Called by InboxScreen right after Get.put to seed header data from
  /// the ChatItem that was passed via the route extra.
  /// Uses [participants.lastOrNull] which is consistent with ChatTile.
  void initWith(ChatItem chatItem) {
    final other = chatItem.participants?.lastOrNull;
    userName.value = other?.name ?? 'Unknown';
    avatarUrl.value = other?.image?.toString() ?? '';
    receiverId.value = other?.id ?? '';
    receiverRole.value = other?.role ?? 'USER';
  }

  Future<void> getChatList({
    required int pageKey,
    required String id,
    required PagingController<int, InboxMessageDatum> pagingController,
  }) async {
    if (isLoading) return;
    isLoading = true;
    try {
      final response = await apiClient.get(
        url: ApiUrls.getChatMessages(conversationId: id, page: pageKey),
      );
      if (response.statusCode == 200) {
        final newData = InboxMessageModel.fromJson(response.data);
        if (pageKey == 1) {
          inboxModel.value = newData;
        }
        final newItems = newData.data ?? [];
        if (newItems.isEmpty) {
          pagingController.appendLastPage(newItems);
        } else {
          pagingController.appendPage(newItems, pageKey + 1);
        }
      } else {
        pagingController.error = 'An error occurred';
      }
    } catch (e) {
      debugPrint('Error in getChatList: $e');
      pagingController.error = 'An error occurred';
    } finally {
      isLoading = false;
    }
  }

  var callMessageSend = false.obs;

  Future<void> sendMessage({
    required BuildContext context,
    required TextEditingController messageController,
  }) async {
    try {
      if (isBlocked.value) {
        AppToast.error(
          message: 'You have blocked this user. Unblock to send messages.',
        );
        return;
      }
      if (isBlockedByOther.value) {
        AppToast.info(message: 'You cannot send messages to this user.');
        return;
      }
      if (callMessageSend.value) return;
      callMessageSend.value = true;
      debugPrint('Is Socket Connected: ${SocketApi.socket?.connected}');

      final UploadImage imageUploadResponse = await uploadImages();

      if (SocketApi.socket?.connected ?? false) {
        // Body format expected by the server.
        final body = {
          'sender': {
            'id': userId.value,
            'role': userRole.value,
          },
          'receiver': {
            'id': receiverId.value,
            'role': receiverRole.value,
          },
          'text': messageController.text,
          'images': imageUploadResponse.images ?? [],
        };

        SocketApi.socket?.emit('new-message', body);
        debugPrint('Sent new-message: $body');

        messageController.clear();
        selectedImages.clear();
        callMessageSend.value = false;
      } else {
        debugPrint('Socket Null Or Socket Not Connected – Send Message aborted');
        callMessageSend.value = false;
        SocketApi.reconnect();
      }
    } catch (e) {
      callMessageSend.value = false;
      debugPrint('Socket Error sendMessage: $e');
    }
  }

  void listenForNewMessages({
    required String senderId,
    required PagingController<int, InboxMessageDatum> pagingController,
  }) {
    try {
      debugPrint('Setting up message listener for senderId: $senderId');
      SocketApi.socket?.off('message_new/$senderId');

      SocketApi.socket?.on('message_new/$senderId', (data) {
        debugPrint('New message received: $data');
        final newMessage = InboxMessageDatum.fromJson(data);
        final currentMessages = pagingController.itemList ?? [];
        if (!currentMessages.any((msg) => msg.id == newMessage.id)) {
          pagingController.itemList = [newMessage, ...currentMessages];
        }
      });
    } catch (e) {
      debugPrint('Socket Error listenForNewMessages: $e');
    }
  }

  final ImagePicker _picker = ImagePicker();
  RxList<XFile> selectedImages = <XFile>[].obs;

  Future<void> pickImage() async {
    selectedImages.clear();
    final images = await _picker.pickMultiImage(imageQuality: 50, limit: 6);
    if (images.isNotEmpty) {
      selectedImages.addAll(images);
    }
  }

  Future<void> pickCameraImage() async {
    selectedImages.clear();
    final image = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );
    if (image != null) {
      selectedImages.add(image);
    }
  }

  void removeImage(int index) {
    if (index >= 0 && index < selectedImages.length) {
      selectedImages.removeAt(index);
    }
  }

  Future<UploadImage> uploadImages() async {
    try {
      if (selectedImages.isNotEmpty) {
        final multipartBody = selectedImages.map((item) {
          return MultipartBody(fieldKey: 'chatImage', file: File(item.path));
        }).toList();

        final response = await apiClient.uploadMultipart(
          url: ApiUrls.chatFileUpload(),
          files: multipartBody,
          method: 'POST',
          token: '',
        );

        if (response.statusCode == 200) {
          return UploadImage.fromJson(response.data);
        } else {
          return UploadImage();
        }
      } else {
        return UploadImage();
      }
    } catch (e) {
      debugPrint('Error uploading images: $e');
      return UploadImage();
    }
  }

  RxString userId = ''.obs;
  RxString userRole = ''.obs;

  void getUserId() async {
    try {
      userId.value = await localService.getUserId();
      userRole.value = await localService.getRole();
    } catch (e) {
      debugPrint('Error getting user ID/role: $e');
    }
  }

  @override
  void onReady() {
    getUserId();
    super.onReady();
  }

  @override
  void onClose() {
    selectedImages.clear();
    super.onClose();
  }
}

class UploadImage {
  final bool? success;
  final List<String>? images;
  final dynamic video;
  final dynamic cover;

  UploadImage({this.success, this.images, this.video, this.cover});

  factory UploadImage.fromJson(Map<String, dynamic> json) => UploadImage(
    success: json['success'],
    images:
        json['images'] == null
            ? []
            : List<String>.from(json['images']!.map((x) => x)),
    video: json['video'],
    cover: json['cover'],
  );

  Map<String, dynamic> toJson() => {
    'success': success,
    'images': images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    'video': video,
    'cover': cover,
  };
}
