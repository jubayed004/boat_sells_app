import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:boat_sells_app/share/widgets/shimmer/custom_shimmer.dart';

class OverviewShimmer extends StatelessWidget {
  const OverviewShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      sliver: SliverGrid.builder(
        itemCount: 8,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 24.h,
          crossAxisSpacing: 16.w,
          childAspectRatio: 3.5, 
        ),
        itemBuilder: (context, index) {
          return CustomShimmer(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerContainer(
                  width: 28.sp,
                  height: 28.sp,
                  shape: BoxShape.circle,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShimmerContainer(
                        width: 80.w,
                        height: 12.sp,
                        borderRadius: 4.r,
                      ),
                      SizedBox(height: 6.h),
                      ShimmerContainer(
                        width: 50.w,
                        height: 12.sp,
                        borderRadius: 4.r,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
