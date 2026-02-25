import 'package:boat_sells_app/share/widgets/align/custom_align_text.dart';
import 'package:boat_sells_app/share/widgets/text_field/custom_text_field.dart';
import 'package:boat_sells_app/utils/color/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class EngineInfoModel {
  final TextEditingController typeController = TextEditingController();
  final TextEditingController fuelController = TextEditingController();
  final TextEditingController makeController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController powerController = TextEditingController();
  final TextEditingController hoursController = TextEditingController();

  void dispose() {
    typeController.dispose();
    fuelController.dispose();
    makeController.dispose();
    modelController.dispose();
    powerController.dispose();
    hoursController.dispose();
  }
}

class EngineInfoSection extends StatelessWidget {
  final int index;
  final EngineInfoModel engine;
  final VoidCallback onRemove;

  const EngineInfoSection({
    super.key,
    required this.index,
    required this.engine,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomAlignText(
              text: 'Engine Information ${index + 1}',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.subHeadingText,
              ),
            ),
            GestureDetector(
              onTap: onRemove,
              child: Text(
                'Remove',
                style: TextStyle(
                  color: AppColors.redColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        Gap(16.h),
        _buildRow('Engine Type', engine.typeController),
        Gap(10.h),
        _buildRow('Fuel Type', engine.fuelController),
        Gap(10.h),
        _buildRow('Engine Make', engine.makeController),
        Gap(10.h),
        _buildRow('Engine Model', engine.modelController),
        Gap(10.h),
        _buildRow('Horse Power', engine.powerController),
        Gap(10.h),
        _buildRow('Engine Hours', engine.hoursController),
        Gap(20.h),
      ],
    );
  }

  Widget _buildRow(String label, TextEditingController controller) {
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
            // Following the concept of the custom text field wrapper, adjusting styling slightly to look like inline simple boxes.
          ),
        ),
      ],
    );
  }
}
