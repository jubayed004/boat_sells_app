import 'package:boat_sells_app/core/di/injection.dart';
import 'package:boat_sells_app/core/service/datasource/local/local_service.dart';
import 'package:boat_sells_app/core/service/datasource/remote/api_client.dart';
import 'package:boat_sells_app/features/comments/model/comment_model.dart';
import 'package:boat_sells_app/helper/toast/toast_helper.dart';
import 'package:boat_sells_app/utils/api_urls/api_urls.dart';
import 'package:boat_sells_app/utils/config/app_config.dart';
import 'package:boat_sells_app/utils/enum/app_enum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentsController extends GetxController {
  final ApiClient apiClient = sl();
  final LocalService localService = sl();

  // Comment text field
  final TextEditingController commentTextController = TextEditingController();

  // ── Fetch comments ────────────────────────────────────────────
  Rx<ApiStatus> status = ApiStatus.loading.obs;
  final Rx<CommentModel> comment = CommentModel().obs;

  Future<void> getComments({required String postId, bool isRefresh = false}) async {
    try {
      AppConfig.logger.i("Get Comments Method Called");
      if (!isRefresh) {
        status.value = ApiStatus.loading;
      }
      final response = await apiClient.get(url: ApiUrls.getComments(postId: postId));
      AppConfig.logger.i(response.data);
      if (response.statusCode == 200) {
        final newData = CommentModel.fromJson(response.data);
        comment.value = newData;
        if (newData.data == null || newData.data!.isEmpty) {
          status.value = ApiStatus.noDataFound;
        } else {
          status.value = ApiStatus.completed;
        }
      } else {
        status.value = ApiStatus.error;
      }
    } catch (e) {
      status.value = ApiStatus.error;
      AppToast.error(message: e.toString());
    }
  }

  // ── Add comment ───────────────────────────────────────────────
  final addCommentLoading = false.obs;
  String? _currentPostId;

  final replyParentId = RxnString();
  final replyToName = RxnString();

  void setPostId(String id) => _currentPostId = id;

  void setReplyTo(String parentId, String name) {
    replyParentId.value = parentId;
    replyToName.value = name;
  }

  void cancelReply() {
    replyParentId.value = null;
    replyToName.value = null;
  }

  Future<void> addComment() async {
    final text = commentTextController.text.trim();
    if (text.isEmpty) return;
    if (_currentPostId == null || _currentPostId!.isEmpty) return;

    try {
      addCommentLoading.value = true;
      final Map<String, dynamic> body = {'postId': _currentPostId, 'text': text};
      if (replyParentId.value != null) {
        body['parentId'] = replyParentId.value;
      }

      final response = await apiClient.post(
        url: ApiUrls.addComment(),
        body: body,
      );
      AppConfig.logger.i(response.data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        commentTextController.clear();
        cancelReply();
        // Refresh comment list
        await getComments(postId: _currentPostId!, isRefresh: true);
        addCommentLoading.value = false;
      } else {
        addCommentLoading.value = false;
        AppToast.error(message: response.data['message']?.toString() ?? 'Failed');
      }
    } catch (e) {
      addCommentLoading.value = false;
      AppToast.error(message: e.toString());
    }
  }

  @override
  void onClose() {
    commentTextController.dispose();
    super.onClose();
  }
}
