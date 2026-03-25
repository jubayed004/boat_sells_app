import 'package:boat_sells_app/utils/config/app_config.dart';

class ApiUrls {
  static const base = AppConfig.baseURL;
  static String socketUrl({required String id}) => 'http://13.50.247.46?id=$id';
  static String login() => '$base/auth/login';
  static String register() => '$base/auth/register';
  static String verifyOtp() => '$base/auth/verify-otp';
  static String resendOtp() => '$base/auth/resend-otp';
  static String forgotPassword() => '$base/auth/forgot-password';
  static String verifyResetOtp() => '$base/auth/verify-reset-otp';
  static String resetPassword() => '$base/auth/reset-password';
  // =========== Customer Api Urls ===========
  static String getProfile() => '$base/v1/user/get-me';
  static String updateProfile() => '$base/v1/user/update-me';


  //============== Settting===================

  static String changePassword() => '$base/v1/auth/change-password';
  static String termsConditions() => '$base/v1/settings/terms/get';
  static String privacyPolicy() => '$base/v1/settings/privacy/get';
  static String faq() => '$base/v1/settings/faq/get-all';
  static String logout() => '$base/auth/logout';

}
