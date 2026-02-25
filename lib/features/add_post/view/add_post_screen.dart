import 'package:boat_sells_app/core/router/routes.dart';
import 'package:boat_sells_app/features/add_post/controller/add_post_controller.dart';
import 'package:boat_sells_app/features/nav_bar/controller/navigation_controller.dart';
import 'package:boat_sells_app/features/add_post/widgets/additional_info_section.dart';
import 'package:boat_sells_app/features/add_post/widgets/engines_expanded_section.dart';
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
  final AddPostController _controller = Get.find<AddPostController>();
  final navController = Get.find<NavigationControllerMain>();

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
                    Gap(16.h),
                    _buildInlineField(
                      label: 'Boat Type',
                      child: ValueListenableBuilder<String?>(
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
                    ),
                    Gap(10.h),
                    _buildInlineField(
                      label: 'Category',
                      child: ValueListenableBuilder<String?>(
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
                    ),
                    Gap(10.h),
                    _buildInlineField(
                      label: 'Model',
                      child: CustomTextField(
                        controller: _controller.modelController,
                        hintText: 'Enter Model',
                      ),
                    ),
                    Gap(10.h),
                    _buildInlineField(
                      label: 'Year',
                      child: CustomTextField(
                        controller: _controller.yearController,
                        hintText: 'Enter Year',
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    Gap(10.h),
                    _buildInlineField(
                      label: 'Length',
                      child: CustomTextField(
                        controller: _controller.lengthController,
                        hintText: 'Enter Length',
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    Gap(10.h),
                    _buildInlineField(
                      label: 'People Capacity',
                      child: CustomTextField(
                        controller: _controller.capacityController,
                        hintText: 'Enter People Capacity',
                        keyboardType: TextInputType.number,
                      ),
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

                    // ─── Engines Information ─────────────────────────────────
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
                        return EnginesExpandedSection(
                          engines: _controller.engines,
                          onToggle: _controller.toggleEnginesExpanded,
                          onAddEngine: _controller.addEngine,
                          onRemoveEngine: _controller.removeEngine,
                        );
                      },
                    ),

                    // ─── Additional Information ──────────────────────────────
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
                        return AdditionalInfoSection(
                          onToggle: _controller.toggleAdditionalInfoExpanded,
                          manufacturerController:
                              _controller.manufacturerController,
                          bridgeClearanceController:
                              _controller.bridgeClearanceController,
                          engineModelController:
                              _controller.addInfoEngineModelController,
                          fuelCapacityController:
                              _controller.fuelCapacityController,
                          freshWaterTankController:
                              _controller.freshWaterTankController,
                          cruiseSpeedController:
                              _controller.cruiseSpeedController,
                          loaController: _controller.loaController,
                          maxSpeedController: _controller.maxSpeedController,
                          beamController: _controller.beamController,
                          cabinController: _controller.cabinController,
                          draftController: _controller.draftController,
                          mechanicalEquipmentController:
                              _controller.mechanicalEquipmentController,
                          galleyEquipmentController:
                              _controller.galleyEquipmentController,
                          deskHullEquipmentController:
                              _controller.deskHullEquipmentController,
                          navigationSystemController:
                              _controller.navigationSystemController,
                          additionalEquipmentController:
                              _controller.additionalEquipmentController,
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
                  navController.selectedNavIndex.value = 0;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInlineField({required String label, required Widget child}) {
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
        Expanded(child: child),
      ],
    );
  }
}
