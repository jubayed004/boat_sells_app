import 'package:boat_sells_app/features/comments/controller/comments_controller.dart';
import 'package:boat_sells_app/features/comments/model/comment_model.dart';
import 'package:boat_sells_app/share/widgets/network_image/custom_network_image.dart';
import 'package:boat_sells_app/utils/color/app_colors.dart';
import 'package:boat_sells_app/utils/extension/base_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CommentItemWidget extends StatefulWidget {
  final CommentItem comment;
  final bool isReply;

  const CommentItemWidget({
    super.key, 
    required this.comment,
    this.isReply = false,
  });

  @override
  State<CommentItemWidget> createState() => _CommentItemWidgetState();
}

class _CommentItemWidgetState extends State<CommentItemWidget> {
  bool _showReplies = false;

  String _timeAgo(DateTime? dt) {
    if (dt == null) return '';
    final diff = DateTime.now().difference(dt);
    if (diff.inDays >= 1) return '${diff.inDays}d';
    if (diff.inHours >= 1) return '${diff.inHours}h';
    if (diff.inMinutes >= 1) return '${diff.inMinutes}m';
    return 'just now';
  }

  @override
  Widget build(BuildContext context) {
    final avatarUrl = widget.comment.userId?.avatarUrl ?? '';
    final name = widget.comment.userId?.name ?? 'Unknown';
    final timeAgo = _timeAgo(widget.comment.createdAt);
    final text = widget.comment.text ?? '';
    final replies = widget.comment.replies ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        // Avatar
        CircleAvatar(
          radius: 20.r,
          backgroundColor: AppColors.borderColor,
          child: ClipOval(
            child: avatarUrl.isNotEmpty
                ? CustomNetworkImage(
                    imageUrl: avatarUrl,
                    width: 40.r,
                    height: 40.r,
                    fit: BoxFit.cover,
                  )
                : Icon(Icons.person, size: 20.sp, color: AppColors.subHeadingText),
          ),
        ),
        SizedBox(width: 12.w),

        // Content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name and Time
              Row(
                children: [
                  Text(
                    name,
                    style: context.titleSmall.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.headingText,
                      fontSize: 13.sp,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    timeAgo,
                    style: context.bodySmall.copyWith(
                      color: AppColors.hintTextColor,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.h),

              // Comment Text
              Text(
                text,
                style: context.bodyMedium.copyWith(
                  color: AppColors.headingText.withValues(alpha: 0.8),
                  fontSize: 13.sp,
                  height: 1.4,
                ),
              ),
              SizedBox(height: 8.h),

              // Actions
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      final controller = Get.find<CommentsController>();
                      controller.setReplyTo(widget.comment.id ?? '', name);
                    },
                    child: Text(
                      'Reply',
                      style: context.bodySmall.copyWith(
                        color: AppColors.hintTextColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ],
              ),

              // Nested replies
              if (replies.isNotEmpty) ...[
                SizedBox(height: 8.h),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _showReplies = !_showReplies;
                    });
                  },
                  child: Text(
                    _showReplies
                        ? 'Hide Repl${replies.length == 1 ? 'y' : 'ies'}'
                        : 'View ${replies.length} Repl${replies.length == 1 ? 'y' : 'ies'}',
                    style: context.bodySmall.copyWith(
                      color: AppColors.hintTextColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    ),
    if (_showReplies)
      Padding(
        padding: EdgeInsets.only(
          top: 12.h,
          left: widget.isReply ? 0 : 52.w, // Indent only the first level of replies
        ),
        child: Column(
          children: replies.map((reply) => Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: CommentItemWidget(
              comment: reply, 
              isReply: true,
            ),
          )).toList(),
        ),
      ),
  ],
);
  }
}
