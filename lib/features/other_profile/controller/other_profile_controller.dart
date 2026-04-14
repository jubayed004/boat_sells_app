import 'package:boat_sells_app/core/di/injection.dart';
import 'package:boat_sells_app/core/service/datasource/remote/api_client.dart';
import 'package:boat_sells_app/features/home/model/boat_model.dart';
import 'package:boat_sells_app/features/other_profile/model/other_profile_model.dart';
import 'package:boat_sells_app/helper/toast/toast_helper.dart';
import 'package:boat_sells_app/utils/api_urls/api_urls.dart';
import 'package:boat_sells_app/utils/config/app_config.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

class OtherProfileController extends GetxController {
  final ApiClient apiClient = sl();
  final profileLoading = false.obs;
  bool loadingProdileMethod(bool status) => profileLoading.value = status;
  final Rx<OtherProfileModel> otherProfile = OtherProfileModel().obs;
  Future<void> getOtherProfile({required String userId}) async {
    AppConfig.logger.i("Get Profile Method Called for $userId");
    loadingProdileMethod(true);
    try {
      final response = await apiClient.get(url: ApiUrls.getOtherProfile(userId: userId));
      AppConfig.logger.i(response.data);
      if (response.statusCode == 200) {
        final newData = OtherProfileModel.fromJson(response.data);
        otherProfile.value = newData;
        loadingProdileMethod(false);
      }
    } catch (e) {
      loadingProdileMethod(false);
      AppToast.error(message: e.toString());
    }
  }

  // ── Getters to map data to the UI ──
  String get userName => otherProfile.value.data?.name ?? 'Loading...';
  String get avatarUrl => otherProfile.value.data?.avatarUrl ?? '';
  String get bio => otherProfile.value.data?.bio ?? 'No bio provided.';
  int get postCount => otherProfile.value.data?.postsCount ?? 0;
  
  String get facebook => otherProfile.value.data?.socialLinks?.facebook ?? '';
  String get instagram => otherProfile.value.data?.socialLinks?.instagram ?? '';
  String get twitter => otherProfile.value.data?.socialLinks?.twitter ?? '';

  Future<void> launchSocial(String urlString) async {
    if (urlString.isEmpty) {
      AppToast.error(message: 'No link provided.');
      return;
    }
    final Uri url = Uri.parse(urlString);
    try {
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        AppToast.error(message: 'Could not launch $urlString');
      }
    } catch (e) {
      AppToast.error(message: 'Invalid URL.');
    }
  }

  // These aren't in the model yet, so we provide default fallbacks
  int get followersCount => 0; 
  int get followingCount => 0;

  // ── Missing states that UI expects ──
  final RxBool isFollowing = false.obs;
  void toggleFollow() {
    isFollowing.value = !isFollowing.value;
  }

  // To display posts in the profile
  final RxList<BoatItem> userPosts = <BoatItem>[].obs;


}
