import 'package:boat_sells_app/utils/color/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class NotificationItem {
  final String name;
  final String action;
  final String time;
  final String? avatarUrl;

  const NotificationItem({
    required this.name,
    required this.action,
    required this.time,
    this.avatarUrl,
  });
}

class NotificationTile extends StatelessWidget {
  final NotificationItem item;

  const NotificationTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.borderColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: 24.r,
            backgroundColor: AppColors.iconBg,
            backgroundImage: item.avatarUrl != null
                ? NetworkImage(item.avatarUrl!)
                : null,
            child: item.avatarUrl == null
                ? Icon(
                    Icons.person,
                    color: AppColors.subHeadingText,
                    size: 24.sp,
                  )
                : null,
          ),
          Gap(12.w),

          // Text
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(fontSize: 13.sp, color: AppColors.headingText),
                children: [
                  TextSpan(
                    text: '${item.name} ',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  TextSpan(
                    text: item.action,
                    style: const TextStyle(fontWeight: FontWeight.w400),
                  ),
                  TextSpan(
                    text: '  ${item.time}',
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: AppColors.hintTextColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Gap(10.w),

          // Teal icon badge
          Container(
            width: 42.w,
            height: 42.w,
            decoration: BoxDecoration(
              color: const Color(0xFF0D7377),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              Icons.directions_boat_rounded,
              color: AppColors.white,
              size: 22.sp,
            ),
          ),
        ],
      ),
    );
  }
}
