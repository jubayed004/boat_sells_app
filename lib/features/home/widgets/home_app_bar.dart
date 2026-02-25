import 'package:boat_sells_app/core/custom_assets/assets.gen.dart';
import 'package:boat_sells_app/core/router/route_path.dart';
import 'package:boat_sells_app/core/router/routes.dart';
import 'package:boat_sells_app/utils/color/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      floating: true,
      snap: true,
      pinned: false,
      titleSpacing: 16.w,
      surfaceTintColor: Colors.white,
      title: Assets.images.appLogo.image(height: 40.h),
      centerTitle: false,
      actions: [
        Container(
          margin: EdgeInsets.only(right: 16.w),
          width: 40.w,
          height: 40.w,
          decoration: BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.black.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          child: IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(
              Icons.notifications_outlined,
              color: AppColors.headingText,
              size: 20.sp,
            ),
            onPressed: () {
              AppRouter.route.pushNamed(RoutePath.notificationScreen);
            },
          ),
        ),
      ],
    );
  }
}
