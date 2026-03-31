import 'package:boat_sells_app/core/di/injection.dart';
import 'package:boat_sells_app/core/service/datasource/local/local_service.dart';
import 'package:boat_sells_app/core/service/datasource/remote/api_client.dart';
import 'package:boat_sells_app/helper/toast/toast_helper.dart';
import 'package:boat_sells_app/utils/api_urls/api_urls.dart';
import 'package:boat_sells_app/utils/config/app_config.dart';
import 'package:get/get.dart';

class CommonController extends GetxController {
static CommonController get to => Get.find();

    final ApiClient apiClient = sl();
  final LocalService localService = sl();  

    // Saved Post Section
  RxBool savedPostLoading = false.obs;
  bool savedPostLoadingMethod(bool status) => savedPostLoading.value = status;

  Future<void> savedPost({
    required String postId,
  }) async {
    try {
      savedPostLoadingMethod(true);
      final response = await apiClient.post(url: ApiUrls.savePost(id: postId), body: {});
      AppConfig.logger.i(response.data);
      if (response.statusCode == 201) {
        savedPostLoadingMethod(false);
        AppToast.success( message: response.data?['message'].toString() ?? "Success",);
      } else {
        savedPostLoadingMethod(false);
        AppConfig.logger.i(response.data);
      }
    } catch (err) {
      savedPostLoadingMethod(false);
      AppConfig.logger.e(err);
      AppToast.error(message: "Something went wrong");
    }
  } 

// Like Post Section
  RxBool likePostLoading = false.obs;
  bool likePostLoadingMethod(bool status) => likePostLoading.value = status;

  Future<void> likePost({
    required String postId,
  }) async {
    try {
      likePostLoadingMethod(true);
      final response = await apiClient.post(url: ApiUrls.likePost(id: postId), body: {});
      AppConfig.logger.i(response.data);
      if (response.statusCode == 201) {
        likePostLoadingMethod(false);
        AppToast.success( message: response.data?['message'].toString() ?? "Success",);
      } else {
        likePostLoadingMethod(false);
        AppConfig.logger.i(response.data);
      }
    } catch (err) {
      likePostLoadingMethod(false);
      AppConfig.logger.e(err);
      AppToast.error(message: "Something went wrong");
    }
  } 

  //share Post Section
  RxBool sharePostLoading = false.obs;
  bool sharePostLoadingMethod(bool status) => sharePostLoading.value = status;

  Future<void> sharePost({
    required String postId,
  }) async {
    try {
      sharePostLoadingMethod(true);
      final response = await apiClient.post(url: ApiUrls.sharePost(id: postId), body: {});
      AppConfig.logger.i(response.data);
      if (response.statusCode == 201) {
        sharePostLoadingMethod(false);
        AppToast.success( message: response.data?['message'].toString() ?? "Success",);
      } else {
        sharePostLoadingMethod(false);
        AppConfig.logger.i(response.data);
      }
    } catch (err) {
      sharePostLoadingMethod(false);
      AppConfig.logger.e(err);
      AppToast.error(message: "Something went wrong");
    }
  } 
  

}
