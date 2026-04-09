import 'package:boat_sells_app/core/router/route_path.dart';
import 'package:boat_sells_app/core/router/routes.dart';
import 'package:boat_sells_app/features/home/model/boat_model.dart';
import 'package:boat_sells_app/share/widgets/boat_listing_card/boat_listing_card.dart';
import 'package:boat_sells_app/share/widgets/boat_listing_card/boat_listing_shimmer_card.dart';
import 'package:boat_sells_app/utils/color/app_colors.dart';
import 'package:boat_sells_app/utils/extension/base_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:boat_sells_app/features/details_post/controller/details_post_controller.dart';
import 'package:boat_sells_app/features/details_post/widgets/overview_shimmer.dart';
import 'package:boat_sells_app/features/profile/controller/profile_controller.dart';
import 'package:boat_sells_app/share/widgets/no_internet/error_card.dart';
import 'package:boat_sells_app/share/widgets/no_internet/no_data_card.dart';
import 'package:boat_sells_app/share/widgets/no_internet/no_internet_card.dart';
import 'package:boat_sells_app/utils/enum/app_enum.dart';

class DetailsPostScreen extends StatefulWidget {
  final String? postId;

  const DetailsPostScreen({super.key, this.postId});

  @override
  State<DetailsPostScreen> createState() => _DetailsPostScreenState();
}

class _DetailsPostScreenState extends State<DetailsPostScreen> {

  final controller = Get.put(DetailsPostController());
  @override
  void initState() {
    super.initState();
    
    if (widget.postId != null) {
      controller.getDetailsPost(postId: widget.postId!);
    }
  }
@override
void dispose() {
  Get.delete<DetailsPostController>();
  super.dispose();
}

  BoatItem _patchBoatUser(BoatItem boat) {
    if (!Get.isRegistered<ProfileController>()) return boat;
    final profileData = Get.find<ProfileController>().profile.value.data;
    if (profileData == null) return boat;

    final currentUser = boat.user;
    if (currentUser != null && currentUser.id != null && currentUser.id != profileData.id) {
          return boat;
    }

    final needsPatch =
        (currentUser?.name?.isEmpty ?? true) ||
        (currentUser?.avatarUrl?.isEmpty ?? true);

    if (!needsPatch) return boat;

    return BoatItem(
      id: boat.id,
      user: User(
        id: currentUser?.id ?? profileData.id,
        name: currentUser?.name?.isNotEmpty == true
            ? currentUser!.name
            : profileData.name,
        avatarUrl: currentUser?.avatarUrl?.isNotEmpty == true
            ? currentUser!.avatarUrl
            : profileData.avatarUrl,
      ),
      location: boat.location,
      price: boat.price,
      displayTitle: boat.displayTitle,
      media: boat.media,
      likesCount: boat.likesCount,
      commentsCount: boat.commentsCount,
      shareCount: boat.shareCount,
      isLiked: boat.isLiked,
      isSaved: boat.isSaved,
      createdAt: boat.createdAt,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        scrolledUnderElevation: 0,

        actions: [
          IconButton(
            icon: Icon(
              Icons.more_vert_rounded,
              color: AppColors.headingText,
              size: 24.sp,
            ),
            onPressed: () {},
          ),
          SizedBox(width: 8.w),
        ],
      ),
      body: Obx(() {
        switch (controller.status.value) {
          case ApiStatus.internetError:
            return NoInternetCard(
              onTap: () {
                if (widget.postId != null) controller.getDetailsPost(postId: widget.postId!);
              },
            );
          case ApiStatus.error:
            return ErrorCard(
              title: controller.errorMessage.value,
              onTap: () {
                if (widget.postId != null) controller.getDetailsPost(postId: widget.postId!);
              },
            );
          case ApiStatus.noDataFound:
            return NoDataCard(
              title: 'Post not found',
              onTap: () {
                if (widget.postId != null) controller.getDetailsPost(postId: widget.postId!);
              },
            );
          case ApiStatus.loading:
          case ApiStatus.completed:
            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // ── Boat Card ──
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: Builder(builder: (_) {
                      if (controller.status.value == ApiStatus.loading) {
                        return const BoatListingShimmerCard();
                      }

                      final data = controller.detailsPost.value.data;
                      BoatItem boatToShow;
                      if (data != null) {
                        boatToShow = BoatItem.fromJson(data.toJson());
                        boatToShow = _patchBoatUser(boatToShow);
                      } else {
                        // Fallback
                        boatToShow = _demoBoat;
                      }

                      return BoatListingCard(
                        boat: boatToShow,
                        onCommentTap: () =>
                            AppRouter.route.pushNamed(RoutePath.commentsScreen, extra: boatToShow.id),
                      );
                    }),
                  ),
                ),

          // ── Overview Title ──
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 16.h),
              child: Text(
                'Overview',
                style: context.titleMedium.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.headingText,
                ),
              ),
            ),
          ),

          // ── Overview Grid ──
          Builder(builder: (_) {
            final specs = _currentOverviewSpecs;
            
            if (controller.status.value == ApiStatus.loading || specs.isEmpty) {
              return const OverviewShimmer();
            }

            return SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              sliver: SliverGrid.builder(
                itemCount: specs.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 24.h,
                  crossAxisSpacing: 16.w,
                  childAspectRatio:
                      3.5, // Controls the height of grid items relative to width
                ),
                itemBuilder: (context, index) {
                  final spec = specs[index];
                  return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(spec.icon, color: AppColors.primaryBlue, size: 28.sp),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            spec.title,
                            style: context.bodySmall.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryBlue,
                              fontSize: 12.sp,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            spec.value,
                            style: context.bodyMedium.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.headingText,
                              fontSize: 13.sp,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
              ),
            );
          }),

          // ── Bottom Padding ──
          SliverToBoxAdapter(child: SizedBox(height: 24.h)),
        ],
      );
      }
      }),
      // ── Fixed Bottom Actions ──
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 32.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  AppRouter.route.pushNamed(RoutePath.viewFullDetailsScreen);
                },
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  side: BorderSide(color: AppColors.primaryBlue, width: 1.2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                ),
                child: Text(
                  'Details',
                  style: context.labelLarge.copyWith(
                    color: AppColors.primaryBlue,
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  elevation: 0,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                ),
                child: Text(
                  'Contact',
                  style: context.labelLarge.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    
  }

  List<_OverviewItem> get _currentOverviewSpecs {
    final data = controller.detailsPost.value.data;
    if (data == null) return [];

    final boatInfo = data.boatInfo;
    final boatAdditional = data.boatAdditional;
    final engine = data.boatEngine?.engines?.isNotEmpty == true 
        ? data.boatEngine!.engines!.first 
        : null;

    int totalHp = 0;
    if (data.boatEngine?.engines != null) {
      for (var e in data.boatEngine!.engines!) {
        totalHp += e.horsePower ?? 0;
      }
    }

    return [
      _OverviewItem(
        Icons.settings_outlined, 
        'Engine Model', 
        engine?.engineModel ?? boatAdditional?.engineModel ?? 'N/A'
      ),
      _OverviewItem(
        Icons.public, 
        'Total Power', 
        totalHp > 0 ? '$totalHp' : 'N/A'
      ),
      _OverviewItem(
        Icons.timer_outlined, 
        'Engine(S) Hours', 
        engine?.engineHours?.toString() ?? 'N/A'
      ),
      _OverviewItem(
        Icons.sailing_rounded, 
        'Class', 
        boatInfo?.category ?? boatInfo?.boatType ?? 'N/A'
      ),
      _OverviewItem(
        Icons.straighten_rounded, 
        'Length', 
        boatInfo?.length?.toString() ?? 'N/A'
      ),
      _OverviewItem(
        Icons.calendar_month_outlined, 
        'Year', 
        boatInfo?.year?.toString() ?? 'N/A'
      ),
      _OverviewItem(
        Icons.directions_boat_filled_outlined, 
        'Model', 
        boatInfo?.model ?? 'N/A'
      ),
      _OverviewItem(
        Icons.groups_outlined, 
        'Capacity', 
        boatInfo?.peopleCapacity?.toString() ?? 'N/A'
      ),
    ];
  }


}

class _OverviewItem {
  final IconData icon;
  final String title;
  final String value;
  const _OverviewItem(this.icon, this.title, this.value);
}

// Fallback demo boat for testing the screen independently
final BoatItem _demoBoat = BoatItem(
  id: '1',
  media: [Media(url: 'https://images.unsplash.com/photo-1567899378494-47b22a2ae96a?w=800')],
  user: User(name: 'Ivy Marlowe', avatarUrl: 'https://randomuser.me/api/portraits/women/44.jpg'),
  displayTitle: '2027 Mazu Yachts 112DS',
  price: 12000,
  location: 'New York',
  likesCount: 136,
  commentsCount: 136,
  shareCount: 136,
);
