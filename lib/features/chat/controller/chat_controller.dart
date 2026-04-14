import 'package:boat_sells_app/core/di/injection.dart';
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

  /// Class-level PagingController so the screen can reference it directly.
  final PagingController<int, ChatItem> pagingController =
      PagingController<int, ChatItem>(firstPageKey: 1);

  @override
  void onInit() {
    super.onInit();
    pagingController.addPageRequestListener((pageKey) {
      _fetchConversations(pageKey: pageKey);
    });
  }

  // ─── REST: Fetch conversations ──────────────────────────────────────────────

  Future<void> _fetchConversations({required int pageKey}) async {
    try {
      final response = await apiClient.get(
        url: ApiUrls.getChat(page: pageKey),
      );
      AppConfig.logger.d(response.data);

      if (response.statusCode == 200) {
        final chatModel = ChatModel.fromJson(response.data);
        final newItems = chatModel.data ?? [];
        final totalPages = chatModel.meta?.totalPages ?? 1;
        final isLastPage = pageKey >= totalPages || newItems.isEmpty;

        if (isLastPage) {
          pagingController.appendLastPage(newItems);
        } else {
          pagingController.appendPage(newItems, pageKey + 1);
        }
      } else {
        pagingController.error =
            response.data['message'] ?? 'Failed to load conversations';
      }
    } catch (error) {
      AppConfig.logger.e(error);
      pagingController.error = error;
    }
  }

  // ─── Socket: Listen for real-time conversation updates ──────────────────────
  // The server emits 'conversation_update' (not user-scoped) per the API guide.

  void listenForNewConversation() {
    try {
      SocketApi.socket?.off('conversation_update');

      SocketApi.socket?.on('conversation_update', (data) {
        debugPrint('[ChatController] conversation_update: $data');
        try {
          if (data == null) return;

          final raw = data is Map ? Map<String, dynamic>.from(data) : <String, dynamic>{};

          // The conversationId from the socket payload
          final convId = raw['conversationId'] as String?;
          if (convId == null) return;

          // Parse only the lastMessage from the socket payload
          final lastMsg = raw['lastMessage'] != null
              ? LastMessage.fromJson(Map<String, dynamic>.from(raw['lastMessage']))
              : null;

          final current = List<ChatItem>.from(pagingController.itemList ?? []);
          final idx = current.indexWhere((c) => c.id == convId);

          if (idx != -1) {
            // ✅ Existing conversation — keep participants (with name/image), only update lastMessage
            final existing = current[idx];
            final merged = ChatItem(
              id: existing.id,
              participants: existing.participants, // preserve name & image
              meta: existing.meta,
              blockedBy: existing.blockedBy,
              createdAt: existing.createdAt,
              updatedAt: existing.updatedAt,
              v: existing.v,
              lastMessage: lastMsg ?? existing.lastMessage,
            );
            current.removeAt(idx);
            current.insert(0, merged);
            pagingController.itemList = List<ChatItem>.from(current);
            debugPrint('[ChatController] Updated existing conversation. Count: ${current.length}');
          } else {
            // 🆕 New conversation not in list — refresh from REST to get full participant data
            debugPrint('[ChatController] New conversation – refreshing list from REST');
            pagingController.refresh();
          }
        } catch (e) {
          debugPrint('[ChatController] conversation_update parse error: $e');
        }
      });
    } catch (e) {
      debugPrint('[ChatController] listenForNewConversation error: $e');
    }
  }

  void stopListening() {
    SocketApi.socket?.off('conversation_update');
  }

  @override
  void onClose() {
    stopListening();
    pagingController.dispose();
    super.onClose();
  }
}