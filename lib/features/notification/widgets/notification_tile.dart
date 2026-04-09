import 'package:boat_sells_app/utils/color/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import 'package:boat_sells_app/features/notification/model/notification_model.dart';
import 'package:boat_sells_app/share/widgets/network_image/custom_network_image.dart';

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
          CustomNetworkImage(
            imageUrl: item.user?.avatarUrl ?? '',
            height: 48.r,
            width: 48.r,
            boxShape: BoxShape.circle,
            backgroundColor: AppColors.iconBg,
            errorWidget: Icon(
              Icons.person,
              color: AppColors.subHeadingText,
              size: 24.sp,
            ),
          ),
          Gap(12.w),

          // Text
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(fontSize: 13.sp, color: AppColors.headingText),
                children: [
                  TextSpan(
                    text: '${item.user?.name ?? 'Someone'} ',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  TextSpan(
                    text: 'interacted with your post',
                    style: const TextStyle(fontWeight: FontWeight.w400),
                  ),
                  TextSpan(
                    text: item.createdAt != null ? '  ${item.createdAt!.day}/${item.createdAt!.month}' : '',
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
