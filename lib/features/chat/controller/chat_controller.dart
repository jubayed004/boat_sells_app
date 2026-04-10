import 'package:boat_sells_app/core/di/injection.dart';
import 'package:boat_sells_app/core/service/datasource/local/local_service.dart';
import 'package:boat_sells_app/core/service/datasource/remote/api_client.dart';
import 'package:boat_sells_app/core/service/datasource/remote/socket_service.dart';
import 'package:boat_sells_app/features/chat/model/chat_model.dart';
import 'package:boat_sells_app/utils/api_urls/api_urls.dart';
import 'package:boat_sells_app/utils/config/app_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ChatController extends GetxController {
  final ApiClient apiClient = sl();
  final LocalService localService = sl();

  /// Class-level PagingController so the screen can reference it directly.
  final PagingController<int, ChatItem> pagingController =
      PagingController<int, ChatItem>(firstPageKey: 1);

  @override
  void onInit() {
    super.onInit();
    pagingController.addPageRequestListener((pageKey) {
      getChat(pageKey: pageKey);
    });
  }

  Future<void> getChat({required int pageKey}) async {
    try {
      final response = await apiClient.get(
        url: ApiUrls.getChat(page: pageKey),
      );
      AppConfig.logger.d(response.data);
      if (response.statusCode == 200) {
        final chatModel = ChatModel.fromJson(response.data);
        final newItems = chatModel.data ?? [];
        final isLastPage = newItems.length < 10;
        if (isLastPage) {
          pagingController.appendLastPage(newItems);
        } else {
          pagingController.appendPage(newItems, pageKey + 1);
        }
      } else {
        pagingController.error = response.data['message'];
      }
    } catch (error) {
      AppConfig.logger.e(error);
      pagingController.error = error;
    }
  }

  /// Listen for real-time conversation updates via socket.
  /// NOTE: This was previously nested inside [getChat] by mistake.
  void listenForNewConversation() async {
    try {
      final userId = await localService.getUserId();
      SocketApi.socket?.off('conversation_update/$userId');
      SocketApi.socket?.on('conversation_update/$userId', (data) {
        debugPrint(
          '<<<<<=========Conversation Received========>>>>>: ${data.toString()}',
        );

        if (data['messageType'] == 'TEXT') {
          final updatedMessage = ChatItem.fromJson(data);
          final currentMessages = pagingController.itemList ?? [];

          final existingIndex = currentMessages.indexWhere(
            (msg) => msg.id == updatedMessage.id,
          );

          if (existingIndex != -1) {
            if (existingIndex == 0) {
              currentMessages[0] = updatedMessage;
            } else {
              currentMessages.removeAt(existingIndex);
              currentMessages.insert(0, updatedMessage);
            }
          } else {
            currentMessages.insert(0, updatedMessage);
          }

          pagingController.itemList = [...currentMessages];
          debugPrint(
            '<<<<<<===Updated conversation list====>>>>>: ${pagingController.itemList?.length}',
          );
        } else {
          debugPrint('<<<<<===Ignored non-text conversation event=====>>>>>>');
        }
      });
    } catch (e) {
      debugPrint('Socket Error ChatController.listenForNewConversation: $e');
    }
  }

  @override
  void onClose() {
    pagingController.dispose();
    super.onClose();
  }
}