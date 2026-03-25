
import 'package:boat_sells_app/core/di/injection.dart';
import 'package:boat_sells_app/core/router/route_path.dart';
import 'package:boat_sells_app/core/router/routes.dart';
import 'package:boat_sells_app/core/service/datasource/local/local_service.dart';
import 'package:boat_sells_app/core/service/datasource/remote/api_client.dart';
import 'package:boat_sells_app/helper/toast/toast_helper.dart';
import 'package:boat_sells_app/utils/api_urls/api_urls.dart';
import 'package:boat_sells_app/utils/config/app_config.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
    final ApiClient apiClient = sl();
  final LocalService localService = sl();
  // logout

  final logoutLoading = false.obs;
  bool loadingLogoutMethod(bool status) => logoutLoading.value = status;
  Future<void> logout() async {
    loadingLogoutMethod(true);
    try {
      final response = await apiClient.post(url: ApiUrls.logout(), body: {});
      AppConfig.logger.i(response.data);
      if (response.statusCode == 200) {
        await localService.logOut();
        loadingLogoutMethod(false);
        AppToast.success(message: response.data["message"].toString());
        AppRouter.route.goNamed(RoutePath.loginScreen);
      } else {
        loadingLogoutMethod(false);
      }
    } catch (e) {
      loadingLogoutMethod(false);
      AppConfig.logger.e(e.toString());
    }
  }

  
}
