import 'package:boat_sells_app/features/details_post/widgets/detail_widgets.dart';
import 'package:boat_sells_app/utils/color/app_colors.dart';
import 'package:boat_sells_app/utils/extension/base_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:boat_sells_app/features/details_post/controller/details_post_controller.dart';
import 'package:boat_sells_app/utils/enum/app_enum.dart';

class ViewFullDetailsScreen extends StatelessWidget {
  const ViewFullDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DetailsPostController>();

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: Obx(() {
        if (controller.status.value == ApiStatus.loading) {
          return const Center(child: CircularProgressIndicator(color: AppColors.primaryBlue));
        }

        final data = controller.detailsPost.value.data;
        if (data == null) {
          return const Center(child: Text('No details available'));
        }

        final info = data.boatInfo;
        final additional = data.boatAdditional;
        final engines = data.boatEngine?.engines ?? [];

        return SingleChildScrollView(
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
                info?.description ?? 'N/A',
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
              DetailRow(label: '', value: additional?.manufacturer ?? 'N/A'),

              const DetailDivider(),

              // ══════════════════════════════════════
              //  Measurements
              // ══════════════════════════════════════
              DetailSectionTitle(title: 'Measurements'),
              DetailRow(label: 'Specifications', value: additional?.additionalEquipment ?? 'N/A'),
              DetailRow(label: 'Cruising Speed', value: additional?.cruiseSpeed != null ? '${additional?.cruiseSpeed}k' : 'N/A'),
              DetailRow(label: 'Max Speed', value: additional?.maxSpeed != null ? '${additional?.maxSpeed}kt' : 'N/A'),

              const DetailDivider(),

              // ══════════════════════════════════════
              //  Dimensions
              // ══════════════════════════════════════
              DetailSectionTitle(title: 'Dimensions'),
              DetailRow(label: 'Nominal Length', value: info?.length?.toString() ?? 'N/A'),
              DetailRow(label: 'Bridge Overall', value: additional?.bridgeClearance?.toString() ?? 'N/A'),
              DetailRow(label: 'Beam', value: additional?.beam != null ? '${additional?.beam}ft' : 'N/A'),

              const DetailDivider(),

              // ══════════════════════════════════════
              //  Tanks
              // ══════════════════════════════════════
              DetailSectionTitle(title: 'Tanks'),
              DetailRow(label: 'Fresh Water Tanks', value: additional?.freshWaterTank != null ? '${additional?.freshWaterTank}gal' : 'N/A'),
              DetailRow(label: 'Fuel Tanks', value: additional?.fuelCapacity != null ? '${additional?.fuelCapacity}gal' : 'N/A'),

              const DetailDivider(),

              // ══════════════════════════════════════
              //  Accommodations
              // ══════════════════════════════════════
              DetailSectionTitle(title: 'Accommodations'),
              DetailRow(label: 'Cabins', value: additional?.cabin?.toString() ?? 'N/A'),

              const DetailDivider(),

              // ══════════════════════════════════════
              //  Propulsion
              // ══════════════════════════════════════
              DetailSectionTitle(title: 'Propulsion'),

              if (engines.isEmpty)
                const Text('N/A')
              else
                ...engines.asMap().entries.map((entry) {
                  final index = entry.key;
                  final engine = entry.value;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DetailSubLabel(label: 'Engine ${index + 1}'),
                      DetailRow(label: 'Engine Make', value: engine.engineMake ?? 'N/A'),
                      DetailRow(label: 'Engine Model', value: engine.engineModel ?? 'N/A'),
                      DetailRow(label: 'Total Power', value: engine.horsePower != null ? '${engine.horsePower}hp' : 'N/A'),
                      SizedBox(height: 6.h),
                    ],
                  );
                }),

              const DetailDivider(),

              // ══════════════════════════════════════
              //  Features
              // ══════════════════════════════════════
              DetailSectionTitle(title: 'Features'),

              DetailSubLabel(label: 'Technical Equipment'),
              if (additional?.additionalEquipment?.isNotEmpty ?? false)
                ...additional!.additionalEquipment!.split(',').map((e) => BulletItem(text: e.trim()))
              else
                const BulletItem(text: 'N/A'),

              SizedBox(height: 6.h),

              DetailSubLabel(label: 'Inside Equipment'),
              if (additional?.galleyEquipment?.isNotEmpty ?? false)
                ...additional!.galleyEquipment!.split(',').map((e) => BulletItem(text: e.trim()))
              else
                const BulletItem(text: 'N/A'),

              SizedBox(height: 6.h),

              DetailSubLabel(label: 'Outside Equipment'),
              if (additional?.deckHullEquipment?.isNotEmpty ?? false)
                ...additional!.deckHullEquipment!.split(',').map((e) => BulletItem(text: e.trim()))
              else
                const BulletItem(text: 'N/A'),

              const DetailDivider(),

              // ══════════════════════════════════════
              //  Rigging
              // ══════════════════════════════════════
              DetailSectionTitle(title: 'Rigging'),
              if (additional?.mechanicalEquipment?.isNotEmpty ?? false)
                ...additional!.mechanicalEquipment!.split(',').map((e) => BulletItem(text: e.trim()))
              else
                const BulletItem(text: 'N/A'),

              const DetailDivider(),

              // ══════════════════════════════════════
              //  Location
              // ══════════════════════════════════════
              DetailSectionTitle(title: 'Location'),
              if (data.location != null)
                Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: Text(
                    data.location!,
                    style: context.bodySmall.copyWith(
                      fontSize: 13.sp,
                      color: AppColors.subHeadingText,
                    ),
                  ),
                ),

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
                        errorBuilder: (_, _, _) => Container(
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
        );
      }),
    );
  }
}
