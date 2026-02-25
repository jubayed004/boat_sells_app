import 'package:boat_sells_app/core/router/route_path.dart';
import 'package:boat_sells_app/core/router/routes.dart';
import 'package:boat_sells_app/features/saved/controller/saved_controller.dart';
import 'package:boat_sells_app/share/widgets/boat_listing_card/boat_listing_card.dart';
import 'package:boat_sells_app/utils/color/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SavedController());

    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ── App Bar ──────────────────────────────────────────────
          SliverAppBar(
            pinned: true,
            backgroundColor: AppColors.white,
            elevation: 0,
            surfaceTintColor: Colors.transparent,
            centerTitle: true,
            scrolledUnderElevation: 0,
            foregroundColor: Colors.transparent,
            title: Text(
              'Saved',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.headingText,
              ),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(1.h),
              child: Divider(
                height: 1,
                thickness: 1,
                color: AppColors.borderColor,
              ),
            ),
          ),

          // ── Top spacing ──────────────────────────────────────────
          SliverToBoxAdapter(child: SizedBox(height: 16.h)),

          // ── Boat cards list ──────────────────────────────────────
          Obx(() {
            final boats = controller.savedBoats;

            if (boats.isEmpty) {
              return SliverFillRemaining(
                hasScrollBody: false,
                child: _EmptyState(),
              );
            }

            return SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final boat = boats[index];
                return BoatListingCard(
                  boat: boat,
                  onCardTap: () =>
                      AppRouter.route.pushNamed(RoutePath.detailsPostScreen),
                  onCommentTap: () =>
                      AppRouter.route.pushNamed(RoutePath.commentsScreen),
                  imageOnTap: () =>
                      AppRouter.route.pushNamed(RoutePath.otherProfileScreen),
                );
              }, childCount: boats.length),
            );
          }),

          // ── Bottom padding ───────────────────────────────────────
          SliverToBoxAdapter(child: SizedBox(height: 24.h)),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  Empty state widget
// ─────────────────────────────────────────────────────────────
class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 96.w,
          height: 96.w,
          decoration: BoxDecoration(
            color: AppColors.primaryBlue.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.bookmark_border_rounded,
            size: 46.sp,
            color: AppColors.primaryBlue,
          ),
        ),
        SizedBox(height: 20.h),
        Text(
          'No Saved Listings',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.headingText,
          ),
        ),
        SizedBox(height: 8.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          child: Text(
            'Bookmark boats you love and they will appear here.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13.sp,
              color: AppColors.hintTextColor,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
