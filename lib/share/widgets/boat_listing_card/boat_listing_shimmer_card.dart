import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:boat_sells_app/share/widgets/shimmer/custom_shimmer.dart';
import 'package:boat_sells_app/utils/color/app_colors.dart';

class BoatListingShimmerCard extends StatelessWidget {
  const BoatListingShimmerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(14.w, 0, 14.w, 16.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: CustomShimmer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section Placeholder
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
              child: Stack(
                children: [
                  ShimmerContainer(
                    width: double.infinity,
                    height: 210.h,
                    borderRadius: 0,
                  ),
                  Positioned(
                    top: 10.h,
                    left: 10.w,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ShimmerContainer(
                          width: 26.r,
                          height: 26.r,
                          shape: BoxShape.circle,
                        ),
                        SizedBox(width: 6.w),
                        ShimmerContainer(
                          width: 80.w,
                          height: 14.h,
                          borderRadius: 4.r,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            // Info Section Placeholder
            Padding(
              padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 4.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShimmerContainer(
                    width: 150.w,
                    height: 16.h,
                    borderRadius: 4.r,
                  ),
                  ShimmerContainer(
                    width: 50.w,
                    height: 12.h,
                    borderRadius: 4.r,
                  ),
                ],
              ),
            ),
            
            // Price Placeholder
            Padding(
              padding: EdgeInsets.fromLTRB(14.w, 4.h, 14.w, 10.h),
              child: ShimmerContainer(
                width: 80.w,
                height: 16.h,
                borderRadius: 4.r,
              ),
            ),
            
            Divider(
              height: 1,
              thickness: 1,
              color: AppColors.borderColor,
              indent: 14.w,
              endIndent: 14.w,
            ),
            
            // Actions Placeholder
            Padding(
              padding: EdgeInsets.fromLTRB(14.w, 10.h, 14.w, 12.h),
              child: Row(
                children: [
                  ShimmerContainer(
                    width: 40.w,
                    height: 18.h,
                    borderRadius: 4.r,
                  ),
                  SizedBox(width: 18.w),
                  ShimmerContainer(
                    width: 40.w,
                    height: 18.h,
                    borderRadius: 4.r,
                  ),
                  SizedBox(width: 18.w),
                  ShimmerContainer(
                    width: 40.w,
                    height: 18.h,
                    borderRadius: 4.r,
                  ),
                  const Spacer(),
                  ShimmerContainer(
                    width: 20.w,
                    height: 20.h,
                    borderRadius: 4.r,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
