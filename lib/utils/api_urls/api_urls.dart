import 'package:boat_sells_app/utils/config/app_config.dart';

class ApiUrls {
  static const base = AppConfig.baseURL;
  static String socketUrl({required String id}) => 'http://13.50.247.46?id=$id';
  static String login() => '$base/auth/login';
  static String register() => '$base/auth/register';
  static String activeVerifyOtp() => '$base/auth/verify-otp';
  static String resendOtp() => '$base/auth/resend-otp';
  static String forgotPassword() => '$base/auth/forgot-password';
  static String verifyResetOtp() => '$base/auth/verify-reset-otp';
  static String resetPassword() => '$base/auth/reset-password';
  // =========== Customer Api Urls ===========
  static String getProfile() => '$base/users/me';
  static String updateProfile() => '$base/users/update-profile';

// Home Screen
static String getBoats({required int page}) => '$base/posts/feed?limit=10&page=$page';
static String getSavedBoats({required int page}) => '$base/saved?limit=10&page=$page'; 
static String savePost({required String id}) => '$base/saved/$id';
static String sharePost({required String id}) => '$base/posts/$id/share';
static String likePost({required String id}) => '$base/posts/$id/like';
static String getDetailsPost({required String postId}) => '$base/posts/$postId';
//add post
static String addPost() => '$base/posts';

//notification
static String getNotifications({required int page}) => '$base/notifications?page=$page&limit=10';
// Profile Screen
static String getUserAllPost({required int page}) => '$base/posts/me?limit=10&page=$page';
  //============== Settting===================

  static String changePassword() => '$base/users/change-password';
  static String termsConditions() => '$base/legal-content/terms-and-conditions';
  static String privacyPolicy() => '$base/legal-content/privacy-policy';
  static String contactAndSupport() => '$base/contact';
  static String logout() => '$base/auth/logout';
 
//============== Comment==============
static String getComments ({required String postId}) => '$base/comments?postId=$postId';
static String addComment () => '$base/comments';

}
