import 'package:boat_sells_app/features/details_post/widgets/detail_widgets.dart';
import 'package:boat_sells_app/utils/color/app_colors.dart';
import 'package:boat_sells_app/utils/extension/base_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ViewFullDetailsScreen extends StatelessWidget {
  const ViewFullDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ══════════════════════════════════════
            //  Description
            // ══════════════════════════════════════
            DetailSectionTitle(title: 'Description'),
            Text(
              'Maza Yachts Is Proud To Introduce The 112, Mid Size In The '
              '120 Range. After The 82 95 Series, Which Started Production '
              'Last Year, The First Design Process Of The 2030 Model Was Completed. '
              'The1120S Model Features Three Decks, And On Each Deck, The Design '
              'Offers Spacious Saloon. Accommodation Onboard Is For 10 Guests '
              'In 5 Cabins, Including A Guest Cabin And 1 Master Cabin. The Exterior '
              'Is Perfectly Designed For Relaxation.\n\nThe Vessel Offers Lounging And '
              'Dining Areas And Comfortable Sunbathing Platform. Powered By Two Volvo '
              'IPS 10+ (1000HP) Engines, The Yacht Cruises Comfortably At '
              '35 Knots, Reaching A Maximum Speed Of 22 Knots. Comfort Onboard Is '
              'Guaranteed By The Zero Speed Stabilizing System.',
              style: context.bodySmall.copyWith(
                fontSize: 13.sp,
                color: AppColors.subHeadingText,
                height: 1.5,
              ),
            ),

            const DetailDivider(),

            // ══════════════════════════════════════
            //  Manufacturer
            // ══════════════════════════════════════
            DetailSectionTitle(title: 'Manufacturer'),
            DetailRow(label: '', value: 'Mitsubishi'),

            const DetailDivider(),

            // ══════════════════════════════════════
            //  Measurements
            // ══════════════════════════════════════
            DetailSectionTitle(title: 'Measurements'),
            DetailRow(label: 'Specifications', value: ''),
            DetailRow(label: 'Cruising Speed', value: '35k'),
            DetailRow(label: 'Max Speed', value: '27kt'),
            DetailRow(label: 'Range', value: '1700nm'),

            const DetailDivider(),

            // ══════════════════════════════════════
            //  Dimensions
            // ══════════════════════════════════════
            DetailSectionTitle(title: 'Dimensions'),
            DetailRow(label: 'Nominal Length', value: '112.28'),
            DetailRow(label: 'Bridge Overall', value: '112.28'),
            DetailRow(label: 'Diagonal', value: '112.28'),
            DetailRow(label: 'Beam', value: '25.83ft'),

            const DetailDivider(),

            // ══════════════════════════════════════
            //  Tanks
            // ══════════════════════════════════════
            DetailSectionTitle(title: 'Tanks'),
            DetailRow(label: 'Fresh Water Tanks', value: '1050.00gal'),
            DetailRow(label: 'Fuel Tanks', value: '3462.50gal'),

            const DetailDivider(),

            // ══════════════════════════════════════
            //  Accommodations
            // ══════════════════════════════════════
            DetailSectionTitle(title: 'Accommodations'),
            DetailRow(label: 'Cabins', value: '5'),

            const DetailDivider(),

            // ══════════════════════════════════════
            //  Propulsion
            // ══════════════════════════════════════
            DetailSectionTitle(title: 'Propulsion'),

            // Engine 1
            DetailSubLabel(label: 'Engine 1'),
            DetailRow(label: 'Engine Make', value: 'Volvo Penta'),
            DetailRow(label: 'Engine Model', value: 'IPS 1200'),
            DetailRow(label: 'Total Power', value: '1000hp'),

            SizedBox(height: 6.h),

            // Engine 2
            DetailSubLabel(label: 'Engine 2'),
            DetailRow(label: 'Engine Make', value: 'Volvo Penta'),
            DetailRow(label: 'Engine Model', value: 'IPS 1200'),
            DetailRow(label: 'Total Power', value: '1000hp'),

            SizedBox(height: 6.h),

            // Engine 3
            DetailSubLabel(label: 'Engine 3'),
            DetailRow(label: 'Engine Make', value: 'Volvo Penta'),
            DetailRow(label: 'Engine Model', value: 'IPS 1200'),
            DetailRow(label: 'Total Power', value: '1000hp'),

            const DetailDivider(),

            // ══════════════════════════════════════
            //  Features
            // ══════════════════════════════════════
            DetailSectionTitle(title: 'Features'),

            // Technical Equipment
            DetailSubLabel(label: 'Technical Equipment'),
            const BulletItem(text: 'Inverter'),

            SizedBox(height: 6.h),

            // Inside Equipment
            DetailSubLabel(label: 'Inside Equipment'),
            const BulletItem(text: 'Electric Bilge Pump'),
            const BulletItem(text: 'Hot Repair'),
            const BulletItem(text: 'Microwave Oven'),

            SizedBox(height: 6.h),

            // Outside Equipment
            DetailSubLabel(label: 'Outside Equipment'),
            const BulletItem(text: 'Cockpit Shower'),
            const BulletItem(text: 'Crew Mast'),

            const DetailDivider(),

            // ══════════════════════════════════════
            //  Rigging
            // ══════════════════════════════════════
            DetailSectionTitle(title: 'Rigging'),
            const BulletItem(text: 'Steering Wheel'),

            const DetailDivider(),

            // ══════════════════════════════════════
            //  Location
            // ══════════════════════════════════════
            DetailSectionTitle(title: 'Location'),
            SizedBox(height: 4.h),

            // Map placeholder
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Container(
                height: 170.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.sectionBg,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColors.borderColor),
                ),
                child: Stack(
                  children: [
                    // Map background image
                    Image.network(
                      'https://maps.googleapis.com/maps/api/staticmap?center=40.7128,-74.0060&zoom=12&size=600x300&maptype=roadmap&markers=color:red%7C40.7128,-74.0060&key=AIzaSyD-placeholder',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      errorBuilder: (_, __, ___) => Container(
                        color: const Color(0xFFE8EFF4),
                        child: Center(
                          child: Icon(
                            Icons.map_outlined,
                            size: 48.sp,
                            color: AppColors.hintTextColor,
                          ),
                        ),
                      ),
                    ),
                    // Location pin overlay
                    Center(
                      child: Icon(
                        Icons.location_on,
                        size: 36.sp,
                        color: AppColors.primaryBlue,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }
}
