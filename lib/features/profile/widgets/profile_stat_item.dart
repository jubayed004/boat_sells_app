import 'package:boat_sells_app/utils/color/app_colors.dart';
import 'package:boat_sells_app/utils/extension/base_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileStatItem extends StatelessWidget {
  final String value;
  final String label;

  const ProfileStatItem({super.key, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: context.titleSmall.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 14.sp,
            color: AppColors.headingText,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          label,
          style: context.bodySmall.copyWith(
            fontSize: 12.sp,
            color: AppColors.headingText,
          ),
        ),
      ],
    );
  }
}
