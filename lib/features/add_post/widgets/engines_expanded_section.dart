import 'package:boat_sells_app/features/add_post/widgets/engine_info_section.dart';
import 'package:boat_sells_app/share/widgets/align/custom_align_text.dart';
import 'package:boat_sells_app/utils/color/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class EnginesExpandedSection extends StatelessWidget {
  final ValueNotifier<List<EngineInfoModel>> engines;
  final VoidCallback onToggle;
  final VoidCallback onAddEngine;
  final void Function(int index) onRemoveEngine;

  const EnginesExpandedSection({
    super.key,
    required this.engines,
    required this.onToggle,
    required this.onAddEngine,
    required this.onRemoveEngine,
  });

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
                text: 'Engines Information',
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
        ValueListenableBuilder<List<EngineInfoModel>>(
          valueListenable: engines,
          builder: (context, engineList, child) {
            return Column(
              children: [
                for (int i = 0; i < engineList.length; i++)
                  EngineInfoSection(
                    index: i,
                    engine: engineList[i],
                    onRemove: () => onRemoveEngine(i),
                  ),
              ],
            );
          },
        ),
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: onAddEngine,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: AppColors.scaffoldBg,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.add_circle_outline,
                    color: AppColors.primaryBlue,
                    size: 18.sp,
                  ),
                  Gap(6.w),
                  Text(
                    'Add Engine',
                    style: TextStyle(
                      color: AppColors.subHeadingText,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Gap(20.h),
      ],
    );
  }
}
