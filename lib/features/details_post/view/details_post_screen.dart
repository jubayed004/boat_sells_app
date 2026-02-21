import 'package:boat_sells_app/features/home/model/boat_model.dart';
import 'package:boat_sells_app/features/home/widgets/boat_listing_card.dart';
import 'package:boat_sells_app/utils/color/app_colors.dart';
import 'package:boat_sells_app/utils/extension/base_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class DetailsPostScreen extends StatelessWidget {
  final BoatModel? boat;

  const DetailsPostScreen({super.key, this.boat});

  @override
  Widget build(BuildContext context) {
    // If no boat is provided via arguments or constructor, use a fallback demo boat
    final displayBoat = boat ?? (Get.arguments as BoatModel?) ?? _demoBoat;

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
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ── Boat Card ──
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: BoatListingCard(boat: displayBoat),
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
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            sliver: SliverGrid.builder(
              itemCount: _overviewSpecs.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 24.h,
                crossAxisSpacing: 16.w,
                childAspectRatio:
                    3.5, // Controls the height of grid items relative to width
              ),
              itemBuilder: (context, index) {
                final spec = _overviewSpecs[index];
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
          ),

          // ── Bottom Padding ──
          SliverToBoxAdapter(child: SizedBox(height: 24.h)),
        ],
      ),
      // ── Fixed Bottom Actions ──
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 32.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {},
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

  // --- Dummy Overview Data reflecting the screenshot ---
  final List<_OverviewItem> _overviewSpecs = const [
    _OverviewItem(Icons.settings_outlined, 'Engine Model', 'CF02X'),
    _OverviewItem(Icons.public, 'Total Power', '2020'), // World/analytics icon
    _OverviewItem(Icons.timer_outlined, 'Engine(S) Hours', '120'),
    _OverviewItem(Icons.sailing_rounded, 'Class', 'Motor Yacht'),
    _OverviewItem(Icons.straighten_rounded, 'Length', '2020'),
    _OverviewItem(Icons.calendar_month_outlined, 'Year', '2020'),
    _OverviewItem(
      Icons.directions_boat_filled_outlined,
      'Model',
      'Motor Yachtsdel',
    ),
    _OverviewItem(Icons.groups_outlined, 'Capacity', '75'),
  ];
}

class _OverviewItem {
  final IconData icon;
  final String title;
  final String value;
  const _OverviewItem(this.icon, this.title, this.value);
}

// Fallback demo boat for testing the screen independently
final BoatModel _demoBoat = BoatModel(
  id: '1',
  imageUrl:
      'https://images.unsplash.com/photo-1567899378494-47b22a2ae96a?w=800',
  sellerName: 'Ivy Marlowe',
  sellerAvatar: 'https://randomuser.me/api/portraits/women/44.jpg',
  title: '2027 Mazu Yachts 112DS',
  price: 12000.00,
  location: 'New York',
  likes: 136,
  comments: 136,
  shares: 136,
  category: 'Yacht',
);
