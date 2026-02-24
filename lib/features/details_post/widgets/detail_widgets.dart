import 'package:boat_sells_app/utils/color/app_colors.dart';
import 'package:boat_sells_app/utils/extension/base_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ─────────────────────────────────────────
//  Section Title Widget
// ─────────────────────────────────────────
class DetailSectionTitle extends StatelessWidget {
  final String title;
  const DetailSectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h, top: 6.h),
      child: Text(
        title,
        style: context.titleSmall.copyWith(
          fontWeight: FontWeight.w700,
          fontSize: 14.sp,
          color: AppColors.headingText,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────
//  Key-Value Row Widget
// ─────────────────────────────────────────
class DetailRow extends StatelessWidget {
  final String label;
  final String value;
  const DetailRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: Text(
              label,
              style: context.bodySmall.copyWith(
                fontSize: 13.sp,
                color: AppColors.subHeadingText,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              value,
              style: context.bodySmall.copyWith(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.headingText,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────
//  Divider Widget
// ─────────────────────────────────────────
class DetailDivider extends StatelessWidget {
  const DetailDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(height: 20.h, thickness: 1, color: AppColors.borderColor);
  }
}

// ─────────────────────────────────────────
//  Bullet Item Widget (for Features list)
// ─────────────────────────────────────────
class BulletItem extends StatelessWidget {
  final String text;
  const BulletItem({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 6.h, right: 8.w),
            child: Container(
              width: 5.w,
              height: 5.w,
              decoration: const BoxDecoration(
                color: AppColors.subHeadingText,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: context.bodySmall.copyWith(
                fontSize: 13.sp,
                color: AppColors.subHeadingText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────
//  Sub-section Label (e.g., "Engine 1")
// ─────────────────────────────────────────
class DetailSubLabel extends StatelessWidget {
  final String label;
  const DetailSubLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.h, bottom: 4.h),
      child: Text(
        label,
        style: context.bodySmall.copyWith(
          fontSize: 13.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.subHeadingText,
        ),
      ),
    );
  }
}
