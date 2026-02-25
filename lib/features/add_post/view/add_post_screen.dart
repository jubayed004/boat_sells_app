import 'package:boat_sells_app/features/add_post/controller/add_post_controller.dart';
import 'package:boat_sells_app/features/add_post/widgets/engine_info_section.dart';
import 'package:boat_sells_app/features/add_post/widgets/image_picker_row.dart';
import 'package:boat_sells_app/features/add_post/widgets/more_info_tile.dart';
import 'package:boat_sells_app/share/widgets/align/custom_align_text.dart';
import 'package:boat_sells_app/share/widgets/button/custom_button.dart';
import 'package:boat_sells_app/share/widgets/dropdown/custom_dropdown_field.dart';
import 'package:boat_sells_app/share/widgets/text_field/custom_text_field.dart';
import 'package:boat_sells_app/utils/color/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'dart:io';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final AddPostController _controller = Get.put(AddPostController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(title: Text('Create Post'.tr)),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ─── Image Picker ───────────────────────────────────────
                    ValueListenableBuilder<List<File>>(
                      valueListenable: _controller.images,
                      builder: (context, images, child) {
                        return ImagePickerRow(
                          images: images,
                          onAddImage: _controller.pickImage,
                          onRemoveImage: _controller.removeImage,
                        );
                      },
                    ),
                    Gap(16.h),
                    // ─── Title ──────────────────────────────────────────────
                    CustomTextField(
                      title: 'Title',
                      controller: _controller.titleController,
                      hintText: 'Enter Title',
                    ),
                    Gap(10.h),

                    // ─── Location ───────────────────────────────────────────
                    CustomTextField(
                      title: 'Location',
                      controller: _controller.locationController,
                      hintText: 'Add Location',
                      prefixIcon: Icon(
                        Icons.location_on_outlined,
                        color: AppColors.primaryBlue,
                      ),
                    ),
                    Gap(10.h),
                    // ─── Price ──────────────────────────────────────────────
                    CustomTextField(
                      title: 'Price',
                      controller: _controller.priceController,
                      hintText: 'Enter Price',
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      prefixIcon: Icon(
                        Icons.attach_money,
                        color: AppColors.primaryBlue,
                      ),
                    ),
                    Gap(20.h),

                    // ─── Boat Information ───────────────────────────────────
                    CustomAlignText(text: 'Boat Information'),
                    Gap(16),
                    CustomAlignText(
                      text: 'Boat Type',
                      style: context.textTheme.bodyLarge,
                    ),
                    Gap(10.h),
                    ValueListenableBuilder<String?>(
                      valueListenable: _controller.selectedBoatType,
                      builder: (context, selectedType, child) {
                        return CustomDropdownField<String>(
                          hintText: _controller.boatTypes.first,
                          value: selectedType,
                          items: _controller.boatTypes,
                          onChanged: _controller.setBoatType,
                        );
                      },
                    ),
                    Gap(10.h),
                    CustomAlignText(
                      text: 'Category',
                      style: context.textTheme.bodyLarge,
                    ),
                    Gap(10.h),
                    // Category Dropdown
                    ValueListenableBuilder<String?>(
                      valueListenable: _controller.selectedCategory,
                      builder: (context, selectedCategory, child) {
                        return CustomDropdownField<String>(
                          hintText: _controller.categories.first,
                          value: selectedCategory,
                          items: _controller.categories,
                          onChanged: _controller.setCategory,
                        );
                      },
                    ),
                    Gap(10.h),
                    // Model
                    CustomTextField(
                      title: 'Model',
                      controller: _controller.modelController,
                      hintText: 'Enter Model',
                    ),
                    Gap(10.h),
                    // Year
                    CustomTextField(
                      title: 'Year',
                      controller: _controller.yearController,
                      hintText: 'Enter Year',
                      keyboardType: TextInputType.number,
                    ),
                    Gap(10.h),
                    // Length
                    CustomTextField(
                      title: 'Length',
                      controller: _controller.lengthController,
                      hintText: 'Enter Length',
                      keyboardType: TextInputType.number,
                    ),
                    Gap(10.h),
                    // People Capacity
                    CustomTextField(
                      title: 'People Capacity',
                      controller: _controller.capacityController,
                      hintText: 'Enter People Capacity',
                      keyboardType: TextInputType.number,
                    ),

                    Gap(20.h),

                    // ─── Description ─────────────────────────────────────────
                    CustomTextField(
                      title: 'Description',
                      controller: _controller.descriptionController,
                      hintText: 'Enter Description',
                      maxLines: 5,
                      minLines: 5,
                      keyboardType: TextInputType.multiline,
                    ),
                    Gap(20.h),
                    // ─── More Information ────────────────────────────────────
                    CustomAlignText(text: 'More Information'),
                    Gap(10.h),
                    // ─── Engines Information ────────────────────────────────────
                    ValueListenableBuilder<bool>(
                      valueListenable: _controller.isEnginesExpanded,
                      builder: (context, isExpanded, child) {
                        if (!isExpanded) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MoreInfoTile(
                                title: 'Engines Information',
                                onTap: _controller.toggleEnginesExpanded,
                              ),
                              Gap(10.h),
                            ],
                          );
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: _controller.toggleEnginesExpanded,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                              valueListenable: _controller.engines,
                              builder: (context, engines, child) {
                                return Column(
                                  children: [
                                    for (int i = 0; i < engines.length; i++)
                                      EngineInfoSection(
                                        index: i,
                                        engine: engines[i],
                                        onRemove: () =>
                                            _controller.removeEngine(i),
                                      ),
                                  ],
                                );
                              },
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: _controller.addEngine,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                    vertical: 10.h,
                                  ),
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
                      },
                    ),

                    // ─── Additional Information ────────────────────────────────────
                    ValueListenableBuilder<bool>(
                      valueListenable: _controller.isAdditionalInfoExpanded,
                      builder: (context, isExpanded, child) {
                        if (!isExpanded) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MoreInfoTile(
                                title: 'Additional Information',
                                onTap: _controller.toggleAdditionalInfoExpanded,
                              ),
                              Gap(10.h),
                            ],
                          );
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: _controller.toggleAdditionalInfoExpanded,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                            CustomTextField(
                              title: 'Manufacturer',
                              controller: _controller.manufacturerController,
                              hintText: 'Enter Manufacturer',
                            ),
                            Gap(10.h),
                            CustomTextField(
                              title: 'Bridge Clearance',
                              controller: _controller.bridgeClearanceController,
                              hintText: 'Enter Bridge Clearance',
                            ),
                            Gap(10.h),
                            CustomTextField(
                              title: 'Engine Model',
                              controller:
                                  _controller.addInfoEngineModelController,
                              hintText: 'Enter Engine Model',
                            ),
                            Gap(10.h),
                            CustomTextField(
                              title: 'Fuel Capacity',
                              controller: _controller.fuelCapacityController,
                              hintText: 'Enter Fuel Capacity',
                              keyboardType: TextInputType.number,
                            ),
                            Gap(10.h),
                            CustomTextField(
                              title: 'Fresh Water Tank',
                              controller: _controller.freshWaterTankController,
                              hintText: 'Enter Fresh Water Tank',
                              keyboardType: TextInputType.number,
                            ),
                            Gap(10.h),
                            CustomTextField(
                              title: 'Cruise Speed',
                              controller: _controller.cruiseSpeedController,
                              hintText: 'Enter Cruise Speed',
                              keyboardType: TextInputType.number,
                            ),
                            Gap(10.h),
                            CustomTextField(
                              title: 'LOA (Overall Length)',
                              controller: _controller.loaController,
                              hintText: 'Enter LOA',
                              keyboardType: TextInputType.number,
                            ),
                            Gap(10.h),
                            CustomTextField(
                              title: 'Max Speed',
                              controller: _controller.maxSpeedController,
                              hintText: 'Enter Max Speed',
                              keyboardType: TextInputType.number,
                            ),
                            Gap(10.h),
                            CustomTextField(
                              title: 'Beam',
                              controller: _controller.beamController,
                              hintText: 'Enter Beam',
                              keyboardType: TextInputType.number,
                            ),
                            Gap(10.h),
                            CustomTextField(
                              title: 'Cabin',
                              controller: _controller.cabinController,
                              hintText: 'Enter Cabin',
                              keyboardType: TextInputType.number,
                            ),
                            Gap(10.h),
                            CustomTextField(
                              title: 'Draft',
                              controller: _controller.draftController,
                              hintText: 'Enter Draft',
                              keyboardType: TextInputType.number,
                            ),
                            Gap(10.h),
                            CustomTextField(
                              title: 'Mechanical Equipment',
                              controller:
                                  _controller.mechanicalEquipmentController,
                              hintText: 'Write Here...',
                              minLines: 3,
                              maxLines: 5,
                            ),
                            Gap(10.h),
                            CustomTextField(
                              title: 'Galley Equipment',
                              controller: _controller.galleyEquipmentController,
                              hintText: 'Write Here...',
                              minLines: 3,
                              maxLines: 5,
                            ),
                            Gap(10.h),
                            CustomTextField(
                              title: 'Desk & Hull Equipment',
                              controller:
                                  _controller.deskHullEquipmentController,
                              hintText: 'Write Here...',
                              minLines: 3,
                              maxLines: 5,
                            ),
                            Gap(10.h),
                            CustomTextField(
                              title: 'Navigation System',
                              controller:
                                  _controller.navigationSystemController,
                              hintText: 'Write Here...',
                              minLines: 3,
                              maxLines: 5,
                            ),
                            Gap(10.h),
                            CustomTextField(
                              title: 'Additional Equipment',
                              controller:
                                  _controller.additionalEquipmentController,
                              hintText: 'Write Here...',
                              minLines: 3,
                              maxLines: 5,
                            ),
                            Gap(24.h),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            // ─── Share Button ─────────────────────────────────────────────
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
              child: CustomButton(
                text: 'Share',
                onTap: () {
                  // TODO: Implement post submission
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
