import 'package:boat_sells_app/share/widgets/align/custom_align_text.dart';
import 'package:boat_sells_app/share/widgets/text_field/custom_text_field.dart';
import 'package:boat_sells_app/utils/color/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AdditionalInfoSection extends StatelessWidget {
  final VoidCallback onToggle;

  // Inline (row) field controllers
  final TextEditingController manufacturerController;
  final TextEditingController bridgeClearanceController;
  final TextEditingController engineModelController;
  final TextEditingController fuelCapacityController;
  final TextEditingController freshWaterTankController;
  final TextEditingController cruiseSpeedController;
  final TextEditingController loaController;
  final TextEditingController maxSpeedController;
  final TextEditingController beamController;
  final TextEditingController cabinController;
  final TextEditingController draftController;

  // Multi-line textarea controllers
  final TextEditingController mechanicalEquipmentController;
  final TextEditingController galleyEquipmentController;
  final TextEditingController deskHullEquipmentController;
  final TextEditingController navigationSystemController;
  final TextEditingController additionalEquipmentController;

  const AdditionalInfoSection({
    super.key,
    required this.onToggle,
    required this.manufacturerController,
    required this.bridgeClearanceController,
    required this.engineModelController,
    required this.fuelCapacityController,
    required this.freshWaterTankController,
    required this.cruiseSpeedController,
    required this.loaController,
    required this.maxSpeedController,
    required this.beamController,
    required this.cabinController,
    required this.draftController,
    required this.mechanicalEquipmentController,
    required this.galleyEquipmentController,
    required this.deskHullEquipmentController,
    required this.navigationSystemController,
    required this.additionalEquipmentController,
  });

  Widget _buildInlineRow({
    required String label,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Row(
      children: [
        SizedBox(
          width: 120.w,
          child: CustomAlignText(
            text: label,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.headingText,
            ),
          ),
        ),
        Expanded(
          child: CustomTextField(
            controller: controller,
            hintText: 'Enter $label',
            keyboardType: keyboardType,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onToggle,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomAlignText(
                text: 'Additional Information',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.subHeadingText,
                ),
              ),
              Icon(
                Icons.keyboard_arrow_up_rounded,
                color: AppColors.subHeadingText,
              ),
            ],
          ),
        ),
        Gap(16.h),
        _buildInlineRow(
          label: 'Manufacturer',
          controller: manufacturerController,
        ),
        Gap(10.h),
        _buildInlineRow(
          label: 'Bridge Clearance',
          controller: bridgeClearanceController,
        ),
        Gap(10.h),
        _buildInlineRow(
          label: 'Engine Model',
          controller: engineModelController,
        ),
        Gap(10.h),
        _buildInlineRow(
          label: 'Fuel Capacity',
          controller: fuelCapacityController,
          keyboardType: TextInputType.number,
        ),
        Gap(10.h),
        _buildInlineRow(
          label: 'Fresh Water Tank',
          controller: freshWaterTankController,
          keyboardType: TextInputType.number,
        ),
        Gap(10.h),
        _buildInlineRow(
          label: 'Cruise Speed',
          controller: cruiseSpeedController,
          keyboardType: TextInputType.number,
        ),
        Gap(10.h),
        _buildInlineRow(
          label: 'LOA (Overall Length)',
          controller: loaController,
          keyboardType: TextInputType.number,
        ),
        Gap(10.h),
        _buildInlineRow(
          label: 'Max Speed',
          controller: maxSpeedController,
          keyboardType: TextInputType.number,
        ),
        Gap(10.h),
        _buildInlineRow(
          label: 'Beam',
          controller: beamController,
          keyboardType: TextInputType.number,
        ),
        Gap(10.h),
        _buildInlineRow(
          label: 'Cabin',
          controller: cabinController,
          keyboardType: TextInputType.number,
        ),
        Gap(10.h),
        _buildInlineRow(
          label: 'Draft',
          controller: draftController,
          keyboardType: TextInputType.number,
        ),
        Gap(10.h),
        CustomTextField(
          title: 'Mechanical Equipment',
          controller: mechanicalEquipmentController,
          hintText: 'Write Here...',
          minLines: 3,
          maxLines: 5,
        ),
        Gap(10.h),
        CustomTextField(
          title: 'Galley Equipment',
          controller: galleyEquipmentController,
          hintText: 'Write Here...',
          minLines: 3,
          maxLines: 5,
        ),
        Gap(10.h),
        CustomTextField(
          title: 'Desk & Hull Equipment',
          controller: deskHullEquipmentController,
          hintText: 'Write Here...',
          minLines: 3,
          maxLines: 5,
        ),
        Gap(10.h),
        CustomTextField(
          title: 'Navigation System',
          controller: navigationSystemController,
          hintText: 'Write Here...',
          minLines: 3,
          maxLines: 5,
        ),
        Gap(10.h),
        CustomTextField(
          title: 'Additional Equipment',
          controller: additionalEquipmentController,
          hintText: 'Write Here...',
          minLines: 3,
          maxLines: 5,
        ),
        Gap(24.h),
      ],
    );
  }
}
