import 'package:boat_sells_app/features/chat/model/chat_model.dart';
import 'package:boat_sells_app/features/inbox/model/inbox_model.dart';
import 'package:boat_sells_app/utils/color/app_colors.dart';
import 'package:boat_sells_app/utils/extension/base_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatTile extends StatelessWidget {
  final ChatModel chat;
  final VoidCallback? onTap;

  const ChatTile({super.key, required this.chat, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        child: Row(
          children: [
            // Avatar
            CircleAvatar(
              radius: 26.r,
              backgroundColor: AppColors.borderColor,
              backgroundImage: NetworkImage(chat.avatarUrl),
            ),
            SizedBox(width: 14.w),

            // Name & Message
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chat.userName,
                    style: context.titleSmall.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 14.sp,
                      color: AppColors.headingText,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    chat.lastMessage,
                    style: context.bodySmall.copyWith(
                      fontSize: 12.sp,
                      color: AppColors.hintTextColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // Time
            Text(
              chat.time,
              style: context.bodySmall.copyWith(
                fontSize: 11.sp,
                color: AppColors.hintTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
