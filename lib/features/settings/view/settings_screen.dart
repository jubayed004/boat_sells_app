import 'package:boat_sells_app/core/router/route_path.dart';
import 'package:boat_sells_app/core/router/routes.dart';
import 'package:boat_sells_app/share/widgets/button/custom_button.dart';
import 'package:boat_sells_app/utils/color/app_colors.dart';
import 'package:boat_sells_app/utils/extension/base_extension.dart';
import 'package:boat_sells_app/features/settings/widgets/settings_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(title: const Text('Settings'), titleSpacing: 0),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),

              SettingsTile(
                icon: Icons.settings_outlined,
                title: 'Change Password',
                onTap: () {
                  AppRouter.route.pushNamed(RoutePath.changePasswordScreen);
                },
              ),
              SettingsTile(
                icon: Icons.bookmark_border_rounded,
                title: 'Saved',
                onTap: () {
                  AppRouter.route.pushNamed(RoutePath.savedScreen);
                },
              ),
              SettingsTile(
                icon: Icons.help_outline_rounded,
                title: 'Contact & Support',
                onTap: () {
                  AppRouter.route.pushNamed(RoutePath.contactAndSupportScreen);
                },
              ),
              SettingsTile(
                icon: Icons.assignment_outlined,
                title: 'Terms & Condition',
                onTap: () {
                  AppRouter.route.pushNamed(RoutePath.termsAndConditionsScreen);
                },
              ),
              SettingsTile(
                icon: Icons.privacy_tip_outlined,
                title: 'Privacy & Policy',
                onTap: () {
                  AppRouter.route.pushNamed(RoutePath.privacyPolicyScreen);
                },
              ),
              SettingsTile(
                icon: Icons.logout_rounded,
                title: 'Logout',
                iconColor: AppColors.favoriteRed,
                titleColor: AppColors
                    .headingText, // As per design, label is dark text, icon is red
                showArrow: false,
                onTap: () {
                  _showLogoutDialog(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          title: Text(
            'Logout',
            style: context.titleMedium.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.headingText,
            ),
          ),
          content: Text(
            'Are you sure you want to logout?',
            style: context.bodyMedium.copyWith(color: AppColors.subHeadingText),
          ),
          actions: [
            TextButton(
              onPressed: () => AppRouter.route.pop(),
              child: Text(
                'Cancel',
                style: context.titleSmall.copyWith(
                  color: AppColors.hintTextColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            CustomButton(
              text: 'Logout',
              onTap: () {
                AppRouter.route.goNamed(RoutePath.loginScreen);
                //AppRouter.route.offAllNamed(RoutePath.loginScreen);
              },
            ),
          ],
        );
      },
    );
  }
}

// The SettingsTile class definition has been removed from this file
// as per the instruction to add an import for it, implying it now resides
// in 'package:boat_sells_app/features/settings/widgets/settings_tile.dart'.
