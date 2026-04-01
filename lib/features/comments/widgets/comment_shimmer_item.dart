import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:boat_sells_app/share/widgets/shimmer/custom_shimmer.dart';

class CommentShimmerItem extends StatelessWidget {
  const CommentShimmerItem({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomShimmer(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar
          ShimmerContainer(
            width: 40.r,
            height: 40.r,
            shape: BoxShape.circle,
          ),
          SizedBox(width: 12.w),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name and Time
                Row(
                  children: [
                    ShimmerContainer(
                      width: 100.w,
                      height: 14.h,
                      borderRadius: 4.r,
                    ),
                    SizedBox(width: 8.w),
                    ShimmerContainer(
                      width: 40.w,
                      height: 12.h,
                      borderRadius: 4.r,
                    ),
                  ],
                ),
                SizedBox(height: 8.h),

                // Comment Text (2 lines)
                ShimmerContainer(
                  width: double.infinity,
                  height: 12.h,
                  borderRadius: 4.r,
                ),
                SizedBox(height: 4.h),
                ShimmerContainer(
                  width: 200.w,
                  height: 12.h,
                  borderRadius: 4.r,
                ),
                SizedBox(height: 12.h),

                // Reply Action
                ShimmerContainer(
                  width: 40.w,
                  height: 12.h,
                  borderRadius: 4.r,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
