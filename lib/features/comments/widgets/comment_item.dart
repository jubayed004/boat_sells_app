import 'package:boat_sells_app/features/comments/model/comment_model.dart';
import 'package:boat_sells_app/utils/color/app_colors.dart';
import 'package:boat_sells_app/utils/extension/base_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommentItem extends StatelessWidget {
  final CommentModel comment;

  const CommentItem({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Avatar
        CircleAvatar(
          radius: 20.r,
          backgroundColor: AppColors.borderColor,
          backgroundImage: NetworkImage(comment.avatarUrl),
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
                    comment.userName,
                    style: context.titleSmall.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.headingText,
                      fontSize: 13.sp,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    comment.timeAgo,
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
                comment.text,
                style: context.bodyMedium.copyWith(
                  color: AppColors.headingText.withOpacity(0.8),
                  fontSize: 13.sp,
                  height: 1.4,
                ),
              ),
              SizedBox(height: 8.h),

              // Actions (Reply)
              Row(
                children: [
                  GestureDetector(
                    onTap: () {},
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

              // View More Replies
              if (comment.repliesCount > 0) ...[
                SizedBox(height: 8.h),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'View More Reply',
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
    );
  }
}
