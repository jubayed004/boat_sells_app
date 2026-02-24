import 'package:boat_sells_app/features/inbox/model/inbox_model.dart';
import 'package:boat_sells_app/utils/color/app_colors.dart';
import 'package:boat_sells_app/utils/extension/base_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatBubble extends StatelessWidget {
  final InboxMessageModel message;

  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final isSent = message.isSent;

    return Align(
      alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
          top: 6.h,
          bottom: 6.h,
          left: isSent ? 60.w : 0,
          right: isSent ? 0 : 60.w,
        ),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isSent ? AppColors.primaryBlue : const Color(0xFFF0F4F8),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.r),
            topRight: Radius.circular(16.r),
            bottomLeft: Radius.circular(isSent ? 16.r : 4.r),
            bottomRight: Radius.circular(isSent ? 4.r : 16.r),
          ),
        ),
        child: Text(
          message.text,
          style: context.bodySmall.copyWith(
            fontSize: 13.sp,
            color: isSent ? AppColors.white : AppColors.headingText,
            height: 1.4,
          ),
        ),
      ),
    );
  }
}
