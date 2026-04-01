import 'package:boat_sells_app/features/profile/controller/profile_controller.dart';
import 'package:boat_sells_app/share/widgets/button/custom_button.dart';
import 'package:boat_sells_app/share/widgets/network_image/custom_network_image.dart';
import 'package:boat_sells_app/share/widgets/text_field/custom_text_field.dart';
import 'package:boat_sells_app/utils/color/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:io';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final ProfileController _profileController = Get.find<ProfileController>();
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _bioController;
  late final TextEditingController _fbController;
  late final TextEditingController _igController;
  late final TextEditingController _twitterController;

  @override
  void initState() {
    super.initState();
    final data = _profileController.profile.value.data;
    _nameController = TextEditingController(text: data?.name ?? '');
    _phoneController = TextEditingController(text: data?.phone ?? '');
    _bioController = TextEditingController(text: data?.bio ?? '');
    _fbController = TextEditingController(
      text: data?.socialLinks?.facebook?.toString() ?? '',
    );
    _igController = TextEditingController(
      text: data?.socialLinks?.instagram?.toString() ?? '',
    );
    _twitterController = TextEditingController(
      text: data?.socialLinks?.twitter?.toString() ?? '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _bioController.dispose();
    _fbController.dispose();
    _igController.dispose();
    _twitterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(title: Text('Edit Profile'), titleSpacing: 0),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // ── Profile Photo Editor ──
                      Center(
                        child: Stack(
                          children: [
                            Container(
                              height: 120.h,
                              width: 120.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.primaryBlue.withValues(alpha: 0.2),
                                  width: 4,
                                ),
                              ),
                              child: ClipOval(
                                child: Obx(() {
                                  if (_profileController.selectedImage.value !=
                                      null) {
                                    return Image.file(
                                      File(
                                        _profileController
                                                .selectedImage
                                                .value
                                                ?.path ??
                                            "",
                                      ),
                                      fit: BoxFit.cover,
                                    );
                                  } else if (_profileController
                                              .profile
                                              .value
                                              .data
                                              ?.avatarUrl !=
                                          null &&
                                      _profileController
                                          .profile
                                          .value
                                          .data!
                                          .avatarUrl!
                                          .isNotEmpty) {
                                    return CustomNetworkImage(
                                      imageUrl:
                                          _profileController
                                              .profile
                                              .value
                                              .data
                                              ?.avatarUrl ??
                                          "",
                                      fit: BoxFit.cover,
                                    );
                                  } else {
                                    return Container(
                                      color: AppColors.priceGreen.withValues(alpha: 0.1),
                                      padding: EdgeInsets.all(20),
                                      child: Icon(Iconsax.user, size: 50),
                                    );
                                  }
                                }),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  _profileController.pickImage();
                                },
                                child: Container(
                                  height: 36,
                                  width: 36,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.priceGreen,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(alpha: 0.2),
                                        blurRadius: 4,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    Iconsax.camera,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 32.h),

                      // ── Input Fields ──
                      CustomTextField(
                        title: 'Name',
                        controller: _nameController,
                        hintText: 'Elowyn Starcrest',
                      ),
                      SizedBox(height: 16.h),
                      CustomTextField(
                        title: "Phone Number",
                        controller: _phoneController,
                        hintText: '1231 131321321',
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(height: 16.h),
                      CustomTextField(
                        title: "Bio",
                        controller: _bioController,
                        hintText: 'Bio',
                        maxLines: 4,
                        minLines: 4,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                      ),
                      SizedBox(height: 16.h),
                      CustomTextField(
                        title: "Facebook",
                        controller: _fbController,
                        hintText: 'Facebook',
                      ),
                      SizedBox(height: 16.h),
                      CustomTextField(
                        title: "Instagram",
                        controller: _igController,
                        hintText: 'Instagram',
                      ),
                      SizedBox(height: 16.h),
                      CustomTextField(
                        title: "Twitter",
                        controller: _twitterController,
                        hintText: 'Twitter',
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // ── Update Button (Fixed Bottom) ──
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Obx(
                () => CustomButton(
                  isLoading: _profileController.updateProfileLoading.value,
                  onTap: () {
                    final body = {
                      'name': _nameController.text,
                      'phone': _phoneController.text,
                      'bio': _bioController.text,
                      "socialLinks": {
                        "facebook": _fbController.text,
                        "instagram": _igController.text,
                        "twitter": _twitterController.text,
                      },
                    };
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      _profileController.updateProfile(body: body);
                    }
                  },
                  text: 'Update',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
