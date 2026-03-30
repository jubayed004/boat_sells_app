import 'dart:io';

import 'package:boat_sells_app/core/di/injection.dart';
import 'package:boat_sells_app/core/router/route_path.dart';
import 'package:boat_sells_app/core/router/routes.dart';
import 'package:boat_sells_app/core/service/datasource/local/local_service.dart';
import 'package:boat_sells_app/core/service/datasource/remote/api_client.dart';
import 'package:boat_sells_app/features/profile/model/profile_model.dart';
import 'package:boat_sells_app/helper/toast/toast_helper.dart';
import 'package:boat_sells_app/utils/api_urls/api_urls.dart';
import 'package:boat_sells_app/utils/config/app_config.dart';
import 'package:boat_sells_app/utils/multipart/multipart_body.dart';
import 'package:get/get.dart';
import 'package:boat_sells_app/features/home/model/boat_model.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  final String userName = 'Ivy Marlowe';
  final String avatarUrl = 'https://randomuser.me/api/portraits/women/44.jpg';
  final int postCount = 3;
  final int followersCount = 114;
  final int followingCount = 37;
  final String bio =
      'A Wanderer Born Under A Rare Celestial Alignment, Elowyn Channels Ancient Starlight To Heal, Protect, And Uncover Forgotten Magic.';

  final List<BoatItem> userPosts = [
    BoatItem(
      id: 'p1',
      media: [
        Media(url: 'https://images.unsplash.com/photo-1569263979104-865ab7cd8d13'),
        Media(url: 'https://images.unsplash.com/photo-1544253106-96de23c4a2bf'),
      ],
      user: User(name: 'Ivy Marlowe', avatarUrl: 'https://randomuser.me/api/portraits/women/44.jpg'),
      displayTitle: '2027 Mazu Yachts 112DS',
      location: 'New York',
      price: 12000,
      likesCount: 136,
      commentsCount: 136,
      shareCount: 136,
    ),
    BoatItem(
      id: 'p2',
      media: [
        Media(url: 'https://images.unsplash.com/photo-1544253106-96de23c4a2bf'),
        Media(url: 'https://images.unsplash.com/photo-1569263979104-865ab7cd8d13'),
      ],
      user: User(name: 'Ivy Marlowe', avatarUrl: 'https://randomuser.me/api/portraits/women/44.jpg'),
      displayTitle: '2027 Mazu Yachts 112DS',
      location: 'New York',
      price: 12000,
      likesCount: 136,
      commentsCount: 136,
      shareCount: 136,
    ),
  ];
  final ImagePicker _imagePicker = ImagePicker();
  final ApiClient apiClient = sl();
  final LocalService localService = sl();

  Rx<XFile?> selectedImage = Rx<XFile?>(null);

  Future<void> pickImage() async {
    XFile? image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (image != null) {
      selectedImage.value = image;
    }
  }

  final profileLoading = false.obs;
  bool loadingProdileMethod(bool status) => profileLoading.value = status;
  final Rx<ProfileModel> profile = ProfileModel().obs;
  Future<void> getProfile() async {
    AppConfig.logger.i("Get Profile Method Called");
    loadingProdileMethod(true);
    try {
      final response = await apiClient.get(url: ApiUrls.getProfile());
      AppConfig.logger.i(response.data);
      if (response.statusCode == 200) {
        final newData = ProfileModel.fromJson(response.data);
        profile.value = newData;
        loadingProdileMethod(false);
      }
    } catch (e) {
      loadingProdileMethod(false);
      AppToast.error(message: e.toString());
    }
  }

  // update profile

  final updateProfileLoading = false.obs;
  bool loadingUpdateProfileMethod(bool status) =>
      updateProfileLoading.value = status;
  Future<void> updateProfile({required Map<String, dynamic> body}) async {
    loadingUpdateProfileMethod(true);
    final token = await localService.getToken();
    try {
      List<MultipartBody> multipartBody = [];

      if (selectedImage.value != null && selectedImage.value!.path.isNotEmpty) {
        multipartBody.add(
          MultipartBody(
            fieldKey: "image",
            file: File(selectedImage.value!.path),
          ),
        );
      }
      final response = await apiClient.uploadMultipart(
        url: ApiUrls.updateProfile(),
        files: multipartBody,
        method: "PATCH",
        token: token,
        fields: body,
      );
      AppConfig.logger.i(response.data);
      if (response.statusCode == 200) {
        await getProfile();
        loadingUpdateProfileMethod(false);
        AppToast.success(message: response.data["message"].toString());
        AppRouter.route.pop();
        return;
      } else {
        loadingUpdateProfileMethod(false);
        AppToast.error(message: response.data["message"].toString());
      }
    } catch (e) {
      loadingUpdateProfileMethod(false);
      AppToast.error(message: e.toString());
    }
  }

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

  @override
  void onReady() {
    super.onReady();
    getProfile();
  }


}
