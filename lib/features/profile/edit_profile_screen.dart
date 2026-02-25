import 'package:boat_sells_app/core/router/routes.dart';
import 'package:boat_sells_app/share/widgets/button/custom_button.dart';
import 'package:boat_sells_app/share/widgets/text_field/custom_text_field.dart';
import 'package:boat_sells_app/utils/color/app_colors.dart';
import 'package:boat_sells_app/utils/extension/base_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController(
    text: 'Elowyn Starcrest',
  );
  final TextEditingController _phoneController = TextEditingController(
    text: '1231 131321321',
  );
  final TextEditingController _bioController = TextEditingController(
    text:
        'A Wanderer Born Under A Rare Celestial Alignment, Elowyn Channels Ancient Starlight To Heal, Protect, And Uncover Forgotten Magic.',
  );
  final TextEditingController _fbController = TextEditingController(
    text: 'https://www.facebook.com',
  );
  final TextEditingController _igController = TextEditingController(
    text: 'https://www.instagram.com',
  );
  final TextEditingController _twitterController = TextEditingController(
    text: 'https://www.twitter.com',
  );

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
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                // TODO: Handle image picking
                              },
                              child: Container(
                                width: 90.r,
                                height: 90.r,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color(0xFFD9D9D9),
                                  image: const DecorationImage(
                                    image: NetworkImage(
                                      'https://randomuser.me/api/portraits/women/44.jpg',
                                    ), // Dummy current image
                                    fit: BoxFit.cover,
                                    colorFilter: ColorFilter.mode(
                                      Colors.white54,
                                      BlendMode.lighten,
                                    ), // Gives it that faded look
                                  ),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.image_outlined,
                                    color: Colors.white,
                                    size: 32.sp,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Text(
                              'Edit Photo',
                              style: context.bodySmall.copyWith(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.headingText,
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
              child: CustomButton(
                onTap: () {
                  AppRouter.route.pop();
                },
                text: 'Update',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
