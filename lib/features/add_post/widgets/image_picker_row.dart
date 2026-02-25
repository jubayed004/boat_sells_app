import 'dart:io';
import 'package:boat_sells_app/utils/color/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImagePickerRow extends StatelessWidget {
  final List<File> images;
  final VoidCallback onAddImage;
  final void Function(int index) onRemoveImage;

  const ImagePickerRow({
    super.key,
    required this.images,
    required this.onAddImage,
    required this.onRemoveImage,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          // Add image button
          GestureDetector(
            onTap: onAddImage,
            child: Container(
              width: 90.w,
              height: 100.h,
              margin: EdgeInsets.only(right: 10.w),
              decoration: BoxDecoration(
                color: AppColors.headingText,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                Icons.camera_alt_outlined,
                color: AppColors.white,
                size: 28.sp,
              ),
            ),
          ),
          // Selected images
          ...List.generate(images.length, (index) {
            return Stack(
              children: [
                Container(
                  width: 90.w,
                  height: 100.h,
                  margin: EdgeInsets.only(right: 10.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    image: DecorationImage(
                      image: FileImage(images[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 4.h,
                  right: 14.w,
                  child: GestureDetector(
                    onTap: () => onRemoveImage(index),
                    child: Container(
                      width: 20.w,
                      height: 20.w,
                      decoration: const BoxDecoration(
                        color: AppColors.favoriteRed,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.close,
                        color: AppColors.white,
                        size: 14.sp,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
