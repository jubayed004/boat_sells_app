import 'package:boat_sells_app/core/custom_assets/assets.gen.dart';
import 'package:boat_sells_app/core/router/route_path.dart';
import 'package:boat_sells_app/core/router/routes.dart';
import 'package:boat_sells_app/features/auth/controller/auth_controller.dart';
import 'package:boat_sells_app/helper/validator/text_field_validator.dart';
import 'package:boat_sells_app/share/widgets/button/custom_button.dart';
import 'package:boat_sells_app/share/widgets/text_field/custom_text_field.dart';
import 'package:boat_sells_app/utils/app_strings/app_strings.dart';
import 'package:boat_sells_app/utils/color/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = Get.find<AuthController>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailSignIn = TextEditingController();
  final TextEditingController passwordSignIn = TextEditingController();

  @override
  void dispose() {
    emailSignIn.dispose();
    passwordSignIn.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(32.h),

                  /// ----------- Logo -----------
                  Center(
                    child: Assets.images.appLogo.image(
                      height: 80.h,
                      fit: BoxFit.contain,
                    ),
                  ),

                  Gap(32.h),

                  /// ----------- Title -----------
                  Text(
                    AppStrings.signIn.tr,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppColors.headingText,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gap(4.h),
                  Text(
                    'Get started',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.subHeadingText,
                    ),
                  ),

                  Gap(24.h),

                  /// ----------- Email Field -----------
                  CustomTextField(
                    controller: emailSignIn,
                    hintText: 'Enter Email Address',
                    keyboardType: TextInputType.emailAddress,
                    validator: TextFieldValidator.email(),
                  ),

                  Gap(14.h),

                  /// ----------- Password Field -----------
                  CustomTextField(
                    controller: passwordSignIn,
                    hintText: 'Enter Password',
                    isPassword: true,
                    validator: TextFieldValidator.password(),
                  ),

                  Gap(24.h),

                  /// ----------- Sign In Button -----------
                  Obx(
                    () => CustomButton(
                      isLoading: _auth.signInLoading.value,
                      text: AppStrings.signIn.tr,
                      onTap: () {
                        AppRouter.route.goNamed(RoutePath.navigationPage);
                        // if (_formKey.currentState!.validate()) {
                        //   _auth.signIn(
                        //     email: emailSignIn.text,
                        //     password: passwordSignIn.text,
                        //   );
                        // }
                      },
                    ),
                  ),

                  Gap(16.h),

                  /// ----------- Forgot Password -----------
                  Center(
                    child: GestureDetector(
                      onTap: () => AppRouter.route.pushNamed(
                        RoutePath.forgetPasswordScreen,
                      ),
                      child: Text(
                        AppStrings.forgotPassword.tr,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.priceGreen,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),

                  Gap(28.h),

                  /// ----------- Sign in with divider -----------
                  Row(
                    children: [
                      const Expanded(
                        child: Divider(
                          color: AppColors.borderColor,
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Text(
                          AppStrings.signInWith.tr,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: AppColors.subHeadingText),
                        ),
                      ),
                      const Expanded(
                        child: Divider(
                          color: AppColors.borderColor,
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),

                  Gap(20.h),

                  /// ----------- Social Icons (Apple + Google) -----------
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /// Apple Button
                      _SocialLoginButton(
                        onTap: () {
                          // TODO: Apple sign in
                        },
                        child: const Icon(
                          Icons.apple,
                          size: 28,
                          color: AppColors.headingText,
                        ),
                      ),

                      Gap(20.w),

                      /// Google Button
                      _SocialLoginButton(
                        onTap: () {
                          // TODO: Google sign in
                        },
                        child: Assets.icons.google.svg(width: 24, height: 24),
                      ),
                    ],
                  ),

                  Gap(40.h),

                  /// ----------- Don't Have An Account -----------
                  Center(
                    child: Text(
                      AppStrings.dontHaveAnAccount.tr,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.subHeadingText,
                      ),
                    ),
                  ),

                  Gap(10.h),

                  /// ----------- Create New Account Button -----------
                  GestureDetector(
                    onTap: () =>
                        AppRouter.route.pushNamed(RoutePath.signUpScreen),
                    child: Container(
                      height: 48.h,
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: AppColors.priceGreen,
                          width: 1.5,
                        ),
                      ),
                      child: Text(
                        'Create New Account',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: AppColors.priceGreen,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                  ),

                  Gap(24.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SocialLoginButton extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;

  const _SocialLoginButton({required this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80.w,
        height: 52.h,
        decoration: BoxDecoration(
          color: AppColors.sectionBg,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.borderColor, width: 1),
        ),
        alignment: Alignment.center,
        child: child,
      ),
    );
  }
}
