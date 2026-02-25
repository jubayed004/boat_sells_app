import 'package:boat_sells_app/utils/color/app_colors.dart';
import 'package:boat_sells_app/utils/extension/base_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? iconColor;
  final Color? titleColor;
  final bool showArrow;

  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.iconColor,
    this.titleColor,
    this.showArrow = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 4.w),
        child: Row(
          children: [
            Icon(icon, size: 24.sp, color: iconColor ?? AppColors.primaryBlue),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(
                title,
                style: context.titleSmall.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: titleColor ?? AppColors.headingText,
                ),
              ),
            ),
            if (showArrow)
              Icon(
                Icons.chevron_right_rounded,
                size: 20.sp,
                color: AppColors.primaryBlue, // Arrow color is cyan in design
              ),
          ],
        ),
      ),
    );
  }
}
