import 'package:boat_sells_app/features/comments/controller/comments_controller.dart';
import 'package:boat_sells_app/features/comments/widgets/comment_item.dart';
import 'package:boat_sells_app/features/comments/widgets/comment_shimmer_item.dart';
import 'package:boat_sells_app/share/widgets/no_internet/error_card.dart';
import 'package:boat_sells_app/share/widgets/no_internet/no_data_card.dart';
import 'package:boat_sells_app/share/widgets/no_internet/no_internet_card.dart';
import 'package:boat_sells_app/utils/color/app_colors.dart';
import 'package:boat_sells_app/utils/enum/app_enum.dart';
import 'package:boat_sells_app/utils/extension/base_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CommentsScreen extends StatefulWidget {
  final String postId;
  const CommentsScreen({super.key, required this.postId});

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final controller = Get.put(CommentsController());

  @override
  void initState() {
    super.initState();
    controller.setPostId(widget.postId);
    controller.getComments(postId: widget.postId);
  }

  @override
  void dispose() {
    Get.delete<CommentsController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text(
          'Comments',
          style: context.titleMedium.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.subHeadingText,
            fontSize: 16.sp,
          ),
        ),
      ),
      body: Column(
        children: [
          // ── Comments List ──────────────────────────────────────
          Expanded(
            child: Obx(() {
              final comments = controller.comment.value.data ?? [];
              return switch (controller.status.value) {
                ApiStatus.loading => CustomScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  slivers: [
                    SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                      sliver: SliverList.separated(
                        itemCount: 8,
                        separatorBuilder: (_, _) => SizedBox(height: 24.h),
                        itemBuilder: (context, index) {
                          return const CommentShimmerItem();
                        },
                      ),
                    ),
                  ],
                ),
                ApiStatus.internetError => NoInternetCard(
                    onTap: () => controller.getComments(postId: widget.postId),
                  ),
                ApiStatus.error => ErrorCard(
                    onTap: () => controller.getComments(postId: widget.postId),
                  ),
                ApiStatus.noDataFound => NoDataCard(
                    onTap: () => controller.getComments(postId: widget.postId),
                    title: 'No Comments Yet',
                    subtitle: 'Be the first to leave a comment!',
                    icon: Icons.chat_bubble_outline_rounded,
                    iconColor: AppColors.primaryBlue,
                  ),
                ApiStatus.completed => RefreshIndicator(
                        onRefresh: () => controller.getComments(postId: widget.postId, isRefresh: true),
                        child: CustomScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          slivers: [
                            SliverPadding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                              sliver: SliverList.separated(
                                itemCount: comments.length,
                                separatorBuilder: (_, _) => SizedBox(height: 24.h),
                                itemBuilder: (context, index) {
                                  return CommentItemWidget(comment: comments[index]);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
              };
            }),
          ),

          // ── Bottom Input Field ─────────────────────────────────
          Container(
            padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 32.h),
            decoration: BoxDecoration(
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() {
                  if (controller.replyToName.value != null) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 8.h, left: 4.w, right: 4.w),
                      child: Row(
                        children: [
                          Text(
                            'Replying to ',
                            style: context.bodySmall.copyWith(
                              color: AppColors.hintTextColor,
                            ),
                          ),
                          Text(
                            controller.replyToName.value!,
                            style: context.titleSmall.copyWith(
                              color: AppColors.primaryBlue,
                              fontWeight: FontWeight.w600,
                              fontSize: 13.sp,
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: controller.cancelReply,
                            child: Icon(Icons.close, size: 16.sp, color: AppColors.hintTextColor),
                          ),
                        ],
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                }),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 50.h,
                        decoration: BoxDecoration(
                          color: AppColors.scaffoldBg,
                          borderRadius: BorderRadius.circular(25.r),
                        ),
                        child: TextField(
                          controller: controller.commentTextController,
                          textInputAction: TextInputAction.send,
                          onSubmitted: (_) => controller.addComment(),
                          decoration: InputDecoration(
                            hintText: 'Comment',
                            hintStyle: context.bodyMedium.copyWith(
                              color: AppColors.hintTextColor,
                              fontSize: 14.sp,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 20.w,
                              vertical: 14.h,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Obx(() => GestureDetector(
                      onTap: controller.addCommentLoading.value ? null : controller.addComment,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        height: 50.h,
                        width: 50.h,
                        decoration: BoxDecoration(
                          color: controller.addCommentLoading.value
                              ? AppColors.primaryBlue.withValues(alpha: 0.5)
                              : AppColors.primaryBlue,
                          shape: BoxShape.circle,
                        ),
                        child: controller.addCommentLoading.value
                            ? Padding(
                                padding: EdgeInsets.all(14.r),
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Icon(
                                Icons.send_rounded,
                                color: AppColors.white,
                                size: 22.sp,
                              ),
                      ),
                    )),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
