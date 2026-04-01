import 'package:boat_sells_app/core/di/injection.dart';
import 'package:boat_sells_app/core/service/datasource/local/local_service.dart';
import 'package:boat_sells_app/core/service/datasource/remote/api_client.dart';
import 'package:boat_sells_app/features/details_post/model/details_post_model.dart';
import 'package:boat_sells_app/helper/toast/toast_helper.dart';
import 'package:boat_sells_app/utils/api_urls/api_urls.dart';
import 'package:boat_sells_app/utils/config/app_config.dart';
import 'package:get/get.dart';

class DetailsPostController extends GetxController {
    final ApiClient apiClient = sl();
  final LocalService localService = sl();
   final detailsPostLoading = false.obs;
  bool loadingDetailsPostMethod(bool status) => detailsPostLoading.value = status;
  final Rx<DetailsPostModel> detailsPost = DetailsPostModel().obs;
  Future<void> getDetailsPost({required String postId}) async {
    AppConfig.logger.i("Get Details Post Method Called");
    loadingDetailsPostMethod(true);
    try {
      final response = await apiClient.get(url: ApiUrls.getDetailsPost(postId: postId));
      AppConfig.logger.i(response.data);
      if (response.statusCode == 200) {
        final newData = DetailsPostModel.fromJson(response.data);
        detailsPost.value = newData;
        loadingDetailsPostMethod(false);
      }
    } catch (e) {
      loadingDetailsPostMethod(false);
      AppToast.error(message: e.toString());
    }
  }

}