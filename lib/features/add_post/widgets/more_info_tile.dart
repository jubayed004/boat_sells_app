import 'package:boat_sells_app/utils/color/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MoreInfoTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const MoreInfoTile({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: AppColors.borderColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.headingText,
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              size: 20.sp,
              color: AppColors.primaryBlue,
            ),
          ],
        ),
      ),
    );
  }
}
