import 'dart:async';
import 'package:boat_sells_app/core/di/injection.dart';
import 'package:boat_sells_app/core/router/route_path.dart';
import 'package:boat_sells_app/core/router/routes.dart';
import 'package:boat_sells_app/core/service/datasource/local/local_service.dart';
import 'package:boat_sells_app/core/service/datasource/remote/api_client.dart';
import 'package:boat_sells_app/helper/toast/toast_helper.dart';
import 'package:boat_sells_app/utils/api_urls/api_urls.dart';
import 'package:boat_sells_app/utils/config/app_config.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AuthController extends GetxController {
  RxInt start = 30.obs;
  RxBool isResendEnabled = false.obs;
  Timer? _timer;
  final ImagePicker _imagePicker = ImagePicker();
  final ApiClient apiClient = sl();
  final LocalService localService = sl();
  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (Timer timer) {
      if (start.value == 0) {
        timer.cancel();
        isResendEnabled.value = true;
      } else {
        start.value--;
      }
    });
  }

  void resendCode() {
    start.value = 30;
    isResendEnabled.value = false;
    startTimer();
  }

  // Sign Up Section
  RxBool signUpLoading = false.obs;
  bool signUpLoadingMethod(bool status) => signUpLoading.value = status;

  Future<void> signUp({
    required String nameSignUp,
    required String emailSignUp,
    required String passwordSignUp,
  }) async {
    try {
      signUpLoadingMethod(true);
      final body = {
        "name": nameSignUp.trim(),
        "email": emailSignUp.trim(),
        "password": passwordSignUp.trim(),
        "role": "USER",
      };

      AppConfig.logger.i(body);

      final response = await apiClient.post(
        url: ApiUrls.register(),
        body: body,
      );

      AppConfig.logger.i(response.data);

      if (response.statusCode == 200) {
        signUpLoadingMethod(false);

        AppToast.success(
          message: response.data?['message'].toString() ?? "Success",
        );

        // final token = response.data?['data']?['accessToken'] as String?;

        // if (token != null) {
        //   await localService.saveToken(token: token);
        // }

        final body = {"email": emailSignUp};

        AppRouter.route.pushNamed(RoutePath.activeOtpScreen, extra: body);
      } else {
        signUpLoadingMethod(false);
        AppToast.error(
          message: response.data?['message'].toString() ?? "Error",
        );
      }
    } catch (err) {
      signUpLoadingMethod(false);
      AppConfig.logger.e(err);
      AppToast.error(message: "Something went wrong");
    }
  }

  // ===================== Verify OTP Section ===============
  RxBool activeOtpLoading = false.obs;
  bool activeOtpLoadingMethod(bool status) => activeOtpLoading.value = status;

  Future<void> activeOtp({required String otp, required String email}) async {
    AppConfig.logger.i("otp $otp");
    try {
      activeOtpLoadingMethod(true);
      final body = {"email": email.trim(), "otp": otp.trim()};

      AppConfig.logger.i(body);

      final response = await apiClient.post(
        url: ApiUrls.activeVerifyOtp(),
        body: body,
      );

      AppConfig.logger.i(response.data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        activeOtpLoadingMethod(false);

        AppToast.success(
          message: response.data?["message"].toString() ?? "Success",
        );
        AppRouter.route.pushNamed(RoutePath.navigationPage, extra: 0);
      } else {
        activeOtpLoadingMethod(false);
        AppToast.error(
          message: response.data?["message"].toString() ?? "Error",
        );
      }
    } catch (err) {
      activeOtpLoadingMethod(false);
      AppConfig.logger.e(err);
      AppToast.error(message: "Something went wrong");
    }
  }

  // ===================== Resend OTP Section ===============

  RxBool resendOtpLoading = false.obs;
  bool resendOtpLoadingMethod(bool status) => resendOtpLoading.value = status;

  Future<void> resendOtp({required String email}) async {
    try {
      resendOtpLoadingMethod(true);
      final body = {"email": email.trim()};

      AppConfig.logger.i(body);

      final response = await apiClient.post(
        url: ApiUrls.resendOtp(),
        body: body,
      );

      AppConfig.logger.i(response.data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        resendOtpLoadingMethod(false);

        AppToast.success(
          message: response.data?["message"].toString() ?? "Success",
        );
      } else {
        resendOtpLoadingMethod(false);
        AppToast.error(
          message: response.data?["message"].toString() ?? "Error",
        );
      }
    } catch (err) {
      resendOtpLoadingMethod(false);
      AppConfig.logger.e(err);
      AppToast.error(message: "Something went wrong");
    }
  }

  // ================== Sign In Section===================
  RxBool signInLoading = false.obs;
  bool signInLoadingMethod(bool status) => signInLoading.value = status;

  Future<void> signIn({required String email, required String password}) async {
    try {
      signInLoadingMethod(true);

      final body = {"email": email.trim(), "password": password.trim()};

      AppConfig.logger.i(body);

      final response = await apiClient.post(url: ApiUrls.login(), body: body);

      AppConfig.logger.i(response.data);

      if (response.statusCode == 200) {
        signInLoadingMethod(false);
        AppToast.success(
          message: response.data?["message"].toString() ?? "Login Successful",
        );

        final data = response.data['data'];
        final token = data['accessToken']?.toString() ?? "";
        final refreshToken = data['refreshToken']?.toString() ?? "";
        final userId = data['user']['userId']?.toString() ?? "";
        final role = data['user']['role']?.toString() ?? "";
        print("User ID $userId");
        
        await localService.saveUserdata(
          token: token,
          refreshToken: refreshToken,
          id: userId,
          role: role,
        );
        AppRouter.route.goNamed(RoutePath.navigationPage);
      } else {
        signInLoadingMethod(false);
        AppToast.error(
          message: response.data?["message"].toString() ?? "Login Failed",
        );
      }
    } catch (err) {
      signInLoadingMethod(false);
      AppConfig.logger.e(err);
      AppToast.error(message: "Something went wrong");
    }
  }

  // ================== Forgot Password Section ===================

  final forgotPasswordLoading = false.obs;
  bool forgotPasswordLoadingMethod(bool status) =>
      forgotPasswordLoading.value = status;
  Future<void> forgotPassword({required String email}) async {
    try {
      forgotPasswordLoadingMethod(true);

      final body = {"email": email.trim()};

      AppConfig.logger.i(body);

      final response = await apiClient.post(
        url: ApiUrls.forgotPassword(),
        body: body,
      );

      AppConfig.logger.i(response.data);

      if (response.statusCode == 200) {
        forgotPasswordLoadingMethod(false);
        AppToast.success(
          message:
              response.data?["message"].toString() ??
              "Forgot Password Successful",
        );
        final body = {"email": email};
        AppRouter.route.goNamed(RoutePath.verifyOtpScreen, extra: body);
      } else {
        forgotPasswordLoadingMethod(false);
        AppToast.error(
          message:
              response.data?["message"].toString() ?? "Forgot Password Failed",
        );
      }
    } catch (err) {
      forgotPasswordLoadingMethod(false);
      AppConfig.logger.e(err);
      AppToast.error(message: "Something went wrong");
    }
  }

  // ================== Verify OTP Section ===================

  final resetVerifyOtpLoading = false.obs;
  bool resetVerifyOtpLoadingMethod(bool status) =>
      resetVerifyOtpLoading.value = status;
  Future<void> resetVerifyOtp({
    required String otp,
    required String email,
  }) async {
    try {
      resetVerifyOtpLoadingMethod(true);

      final body = {"email": email, "otp": otp.trim()};

      AppConfig.logger.i(body);

      final response = await apiClient.post(
        url: ApiUrls.verifyResetOtp(),
        body: body,
      );

      AppConfig.logger.i(response.data);

      if (response.statusCode == 200) {
        resetVerifyOtpLoadingMethod(false);
        AppToast.success(
          message:
              response.data?["message"].toString() ?? "Verify OTP Successful",
        );
        final data = response.data['data'];
        final token = data['resetToken']?.toString() ?? "";

        AppRouter.route.goNamed(RoutePath.resetPasswordScreen, extra: token);
      } else {
        resetVerifyOtpLoadingMethod(false);
        AppToast.error(
          message: response.data?["message"].toString() ?? "Verify OTP Failed",
        );
      }
    } catch (err) {
      resetVerifyOtpLoadingMethod(false);
      AppConfig.logger.e(err);
      AppToast.error(message: "Something went wrong");
    }
  }

  // ================== Reset Password Section ===================

  final resetPasswordLoading = false.obs;
  bool resetPasswordLoadingMethod(bool status) =>
      resetPasswordLoading.value = status;
  Future<void> resetPassword({
    required String password,
    required String token,
  }) async {
    try {
      resetPasswordLoadingMethod(true);

      final body = {"newPassword": password.trim(), "resetToken": token};

      AppConfig.logger.i(body);

      final response = await apiClient.post(
        url: ApiUrls.resetPassword(),
        body: body,
      );

      AppConfig.logger.i(response.data);

      if (response.statusCode == 200) {
        resetPasswordLoadingMethod(false);

        AppToast.success(
          message:
              response.data?["message"].toString() ??
              "Reset Password Successful",
        );

        AppRouter.route.goNamed(RoutePath.loginScreen);
      } else {
        resetPasswordLoadingMethod(false);
        AppToast.error(
          message:
              response.data?["message"].toString() ?? "Reset Password Failed",
        );
      }
    } catch (err) {
      resetPasswordLoadingMethod(false);
      AppConfig.logger.e(err);
      AppToast.error(message: "Something went wrong");
    }
  }
}
