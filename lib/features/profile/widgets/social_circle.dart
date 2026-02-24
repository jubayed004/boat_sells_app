import 'package:boat_sells_app/utils/color/app_colors.dart';
import 'package:boat_sells_app/utils/extension/base_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SocialCircle extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const SocialCircle({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38.r,
        height: 38.r,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.headingText, width: 1.w),
        ),
        child: Text(
          label,
          style: context.labelSmall.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 11.sp,
            color: AppColors.headingText,
          ),
        ),
      ),
    );
  }
}
