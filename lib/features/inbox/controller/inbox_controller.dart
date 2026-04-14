import 'dart:io';

import 'package:boat_sells_app/core/di/injection.dart';
import 'package:boat_sells_app/core/service/datasource/local/local_service.dart';
import 'package:boat_sells_app/core/service/datasource/remote/api_client.dart';
import 'package:boat_sells_app/core/service/datasource/remote/socket_service.dart';
import 'package:boat_sells_app/features/chat/model/chat_model.dart';
import 'package:boat_sells_app/features/inbox/model/inbox_model.dart';
import 'package:boat_sells_app/helper/toast/toast_helper.dart';
import 'package:boat_sells_app/utils/api_urls/api_urls.dart';
import 'package:boat_sells_app/features/other_profile/controller/other_profile_controller.dart';
import 'package:boat_sells_app/utils/multipart/multipart_body.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class InboxController extends GetxController {
  final ApiClient apiClient = sl<ApiClient>();
  final LocalService localService = sl();

  // ─── Header / participant info ──────────────────────────────────────────────
  final RxString avatarUrl = ''.obs;
  final RxString userName = 'Unknown'.obs;
  final RxString receiverId = ''.obs;
  final RxString receiverRole = 'USER'.obs;
  final RxString conversationId = ''.obs;

  // ─── Current user info ──────────────────────────────────────────────────────
  final RxString userId = ''.obs;
  final RxString userRole = ''.obs;

  // ─── UI state ───────────────────────────────────────────────────────────────
  final RxBool callMessageSend = false.obs;
  final RxBool isTyping = false.obs; // other user is typing
  bool _isLoadingMessages = false;

  // ─── Image picker ───────────────────────────────────────────────────────────
  final ImagePicker _picker = ImagePicker();
  final RxList<XFile> selectedImages = <XFile>[].obs;

  // ─── Init ────────────────────────────────────────────────────────────────────

  /// Called by InboxScreen right after Get.put to seed header data from the
  /// ChatItem that was passed via the route extra, OR a bare userId.
  void initWith({ChatItem? chatItem, String? overrideUserId}) {
    if (chatItem != null) {
      conversationId.value = chatItem.id ?? '';
      final other = chatItem.participants?.lastOrNull;
      userName.value = other?.name ?? 'Unknown';
      avatarUrl.value = other?.image?.toString() ?? '';
      receiverId.value = other?.id ?? '';
      receiverRole.value = other?.role ?? 'USER';
    } else if (overrideUserId != null) {
      conversationId.value = '';
      receiverId.value = overrideUserId;
      receiverRole.value = 'USER';
      
      // Try to intelligently extract name and avatar from the Profile Screen if available!
      if (Get.isRegistered<OtherProfileController>()) {
        final profileCtrl = Get.find<OtherProfileController>();
        if (profileCtrl.otherProfile.value.data?.id == overrideUserId) {
          userName.value = profileCtrl.userName;
          avatarUrl.value = profileCtrl.avatarUrl;
          return;
        }
      }
      
      userName.value = 'User';
      avatarUrl.value = '';
    }
  }

  @override
  void onReady() {
    _loadCurrentUser();
    super.onReady();
  }

  Future<void> _loadCurrentUser() async {
    try {
      userId.value = await localService.getUserId();
      userRole.value = await localService.getRole();
      debugPrint('[InboxController] userId=${userId.value} role=${userRole.value}');
    } catch (e) {
      debugPrint('[InboxController] _loadCurrentUser error: $e');
    }
  }

  // ─── REST: Get messages ──────────────────────────────────────────────────────

  Future<void> getChatList({
    required int pageKey,
    required String id,
    required PagingController<int, InboxMessageDatum> pagingController,
  }) async {
    if (_isLoadingMessages) return;
    _isLoadingMessages = true;
    try {
      final response = await apiClient.get(
        url: ApiUrls.getChatMessages(conversationId: id, page: pageKey),
      );
      if (response.statusCode == 200) {
        final newData = InboxMessageModel.fromJson(response.data);
        final newItems = newData.data ?? [];
        final totalPages = newData.meta?.totalPages ?? 1;
        final isLastPage = pageKey >= totalPages || newItems.isEmpty;

        if (isLastPage) {
          pagingController.appendLastPage(newItems);
        } else {
          pagingController.appendPage(newItems, pageKey + 1);
        }
      } else {
        pagingController.error = 'Failed to load messages';
      }
    } catch (e) {
      debugPrint('[InboxController] getChatList error: $e');
      pagingController.error = e;
    } finally {
      _isLoadingMessages = false;
    }
  }

  // ─── REST: Mark as read ──────────────────────────────────────────────────────

  Future<void> markAsRead() async {
    final convId = conversationId.value;
    if (convId.isEmpty) return;
    try {
      // 1. REST call
      final response = await apiClient.post(
        url: ApiUrls.markAsRead(conversationId: convId),
        body: {},
      );
      debugPrint('[InboxController] markAsRead REST: ${response.statusCode}');

      // 2. Socket emit so the sender's UI updates the read-receipt tick
      if (SocketApi.socket?.connected ?? false) {
        SocketApi.socket?.emit('mark_messages_as_read', {
          'conversationId': convId,
          'myId': userId.value,
          'myRole': userRole.value,
          'senderId': receiverId.value,
          'senderRole': receiverRole.value,
        });
        debugPrint('[InboxController] mark_messages_as_read emitted');
      }
    } catch (e) {
      debugPrint('[InboxController] markAsRead error: $e');
    }
  }

  // ─── Socket: Send message ────────────────────────────────────────────────────

  Future<void> sendMessage({
    required BuildContext context,
    required TextEditingController messageController,
  }) async {
    try {
      final text = messageController.text.trim();
      if (text.isEmpty && selectedImages.isEmpty) return;
      if (callMessageSend.value) return;
      callMessageSend.value = true;

      // 1. Upload images first (if any) via REST POST /chat/upload
      final List<String> imageUrls = await _uploadImages();
      print('imageUrls: $imageUrls');
      // 2. Emit send_message via socket
      if (SocketApi.socket?.connected ?? false) {
        final body = {
          'sender': {'id': userId.value, 'role': userRole.value},
          'receiver': {'id': receiverId.value, 'role': receiverRole.value},
          'text': text,
          'images': imageUrls,
        };

        SocketApi.socket?.emit('send_message', body);
        debugPrint('[InboxController] send_message emitted: $body');

        messageController.clear();
        selectedImages.clear();

        // Stop typing indicator after sending
        _emitStopTyping();
      } else {
        debugPrint('[InboxController] Socket not connected – attempting reconnect');
        SocketApi.reconnect();
        AppToast.error(message: 'Connection lost. Please try again.');
      }
    } catch (e) {
      debugPrint('[InboxController] sendMessage error: $e');
      AppToast.error(message: 'Failed to send message.');
    } finally {
      callMessageSend.value = false;
    }
  }

  // ─── Socket: Typing indicators ───────────────────────────────────────────────

  void emitTyping() {
    final convId = conversationId.value;
    if (convId.isEmpty || !(SocketApi.socket?.connected ?? false)) return;
    SocketApi.socket?.emit('typing', {
      'conversationId': convId,
      'sender': {'id': userId.value, 'role': userRole.value},
      'receiver': {'id': receiverId.value, 'role': receiverRole.value},
    });
  }

  void _emitStopTyping() {
    final convId = conversationId.value;
    if (convId.isEmpty || !(SocketApi.socket?.connected ?? false)) return;
    SocketApi.socket?.emit('stop_typing', {
      'conversationId': convId,
      'sender': {'id': userId.value, 'role': userRole.value},
      'receiver': {'id': receiverId.value, 'role': receiverRole.value},
    });
  }

  void emitStopTyping() => _emitStopTyping();

  // ─── Socket: Listen for new messages ─────────────────────────────────────────

  void listenForNewMessages({
    required PagingController<int, InboxMessageDatum> pagingController,
  }) {
    try {
      final senderId = receiverId.value;
      debugPrint('[InboxController] Setting up message_new/$senderId listener');

      // Scoped event for the open chat screen
      SocketApi.socket?.off('message_new/$senderId');
      SocketApi.socket?.on('message_new/$senderId', (data) {
        debugPrint('[InboxController] message_new/$senderId: $data');
        _handleIncomingMessage(data, pagingController);
      });

      // Generic event (used for notification badges – also handle here so
      // messages for THIS conversation still appear if the scoped event fails)
      SocketApi.socket?.off('message_new');
      SocketApi.socket?.on('message_new', (data) {
        final msgConvId = data is Map ? data['conversationId'] : null;
        if (msgConvId == conversationId.value) {
          debugPrint('[InboxController] message_new (generic, matched): $data');
          _handleIncomingMessage(data, pagingController);
        }
      });

      // Listen for read-receipt updates
      SocketApi.socket?.off('mark_messages_as_read');
      SocketApi.socket?.on('mark_messages_as_read', (data) {
        debugPrint('[InboxController] mark_messages_as_read: $data');
        // Optionally update seen status on messages in the list
      });

      // Typing indicators
      SocketApi.socket?.off('typing');
      SocketApi.socket?.on('typing', (data) {
        if (data is Map && data['conversationId'] == conversationId.value) {
          isTyping.value = true;
        }
      });

      SocketApi.socket?.off('stop_typing');
      SocketApi.socket?.on('stop_typing', (data) {
        if (data is Map && data['conversationId'] == conversationId.value) {
          isTyping.value = false;
        }
      });
    } catch (e) {
      debugPrint('[InboxController] listenForNewMessages error: $e');
    }
  }

  void _handleIncomingMessage(
    dynamic data,
    PagingController<int, InboxMessageDatum> pagingController,
  ) {
    try {
      if (data == null) return;
      final newMessage = InboxMessageDatum.fromJson(
        data is Map ? Map<String, dynamic>.from(data) : {},
      );
      final current = List<InboxMessageDatum>.from(pagingController.itemList ?? []);
      if (!current.any((m) => m.id == newMessage.id)) {
        pagingController.itemList = [newMessage, ...current];
      }
    } catch (e) {
      debugPrint('[InboxController] _handleIncomingMessage parse error: $e');
    }
  }

  void stopListening() {
    final senderId = receiverId.value;
    SocketApi.socket?.off('message_new/$senderId');
    SocketApi.socket?.off('message_new');
    SocketApi.socket?.off('mark_messages_as_read');
    SocketApi.socket?.off('typing');
    SocketApi.socket?.off('stop_typing');
    debugPrint('[InboxController] Stopped all socket listeners.');
  }

  // ─── Image picker ────────────────────────────────────────────────────────────

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

  /// Uploads each selected image individually to POST /chat/upload and
  /// returns the list of CDN URLs to include in the send_message payload.
  Future<List<String>> _uploadImages() async {
    if (selectedImages.isEmpty) return [];
    final List<String> urls = [];

    // Explicitly fetch and pass the token so auth header is always present.
    final String token = await localService.getToken();
    debugPrint('[InboxController] Upload token present: ${token.isNotEmpty}');

    for (final xfile in selectedImages) {
      try {
        final response = await apiClient.uploadMultipart(
          url: ApiUrls.chatFileUpload(),
          files: [_buildMultipartBody(xfile)],
          method: 'POST',
          token: token,
        );
        debugPrint('[InboxController] Upload status: ${response.statusCode} data: ${response.data}');
        if ((response.statusCode == 200 || response.statusCode == 201) &&
            response.data['data'] != null) {
          final url = response.data['data']['url'];
          if (url != null) urls.add(url.toString());
        } else {
          debugPrint('[InboxController] Upload failed: ${response.statusCode}');
        }
      } catch (e) {
        debugPrint('[InboxController] Image upload exception: $e');
      }
    }
    debugPrint('[InboxController] Uploaded ${urls.length} image(s): $urls');
    return urls;
  }

  MultipartBody _buildMultipartBody(XFile xfile) {
    return MultipartBody(fieldKey: 'image', file: File(xfile.path));
  }

  @override
  void onClose() {
    stopListening();
    selectedImages.clear();
    super.onClose();
  }
}


