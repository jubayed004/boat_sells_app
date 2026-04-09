import 'package:boat_sells_app/core/di/injection.dart';
import 'package:boat_sells_app/core/service/datasource/local/local_service.dart';
import 'package:boat_sells_app/core/service/datasource/remote/api_client.dart';
import 'package:boat_sells_app/features/details_post/model/details_post_model.dart';
import 'package:boat_sells_app/utils/api_urls/api_urls.dart';
import 'package:boat_sells_app/utils/config/app_config.dart';
import 'package:boat_sells_app/utils/enum/app_enum.dart';
import 'package:get/get.dart';

class DetailsPostController extends GetxController {
  final ApiClient apiClient = sl();
  final LocalService localService = sl();
  
  // State Enum
  final status = ApiStatus.loading.obs;
  final errorMessage = ''.obs;

  final Rx<DetailsPostModel> detailsPost = DetailsPostModel().obs;
  
  Future<void> getDetailsPost({required String postId}) async {
    AppConfig.logger.i("Get Details Post Method Called");
    status.value = ApiStatus.loading;
    
    try {
      final response = await apiClient.get(url: ApiUrls.getDetailsPost(postId: postId));
      AppConfig.logger.i(response.data);
      
      if (response.statusCode == 200) {
        final newData = DetailsPostModel.fromJson(response.data);
        if (newData.data == null) {
          status.value = ApiStatus.noDataFound;
        } else {
          detailsPost.value = newData;
          status.value = ApiStatus.completed;
        }
      } else if (response.statusCode == 0) {
        status.value = ApiStatus.internetError;
      } else {
        errorMessage.value = response.data['message'] ?? 'Something went wrong';
        status.value = ApiStatus.error;
      }
    } catch (e) {
      errorMessage.value = e.toString();
      status.value = ApiStatus.error;
    }
  }
}