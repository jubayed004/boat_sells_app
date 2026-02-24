import 'package:boat_sells_app/features/auth/controller/auth_controller.dart';
import 'package:boat_sells_app/features/chat/controller/chat_controller.dart';
import 'package:boat_sells_app/features/home/controller/home_controller.dart';
import 'package:boat_sells_app/features/nav_bar/controller/navigation_controller.dart';
import 'package:boat_sells_app/features/other/controller/other_controller.dart';
import 'package:boat_sells_app/features/profile/controller/profile_controller.dart';
import 'package:boat_sells_app/share/controller/language_controller.dart';
import 'package:boat_sells_app/utils/common_controller/common_controller.dart';
import 'package:get/get.dart';

void initGetx() {
  //Auth
  Get.lazyPut(() => LanguageController(), fenix: true);
  Get.lazyPut(() => AuthController(), fenix: true);

  //Others
  Get.lazyPut(() => OtherController(), fenix: true);
  Get.lazyPut(() => CommonController(), fenix: true);
  Get.lazyPut(() => NavigationControllerMain(), fenix: true);
  Get.lazyPut(() => HomeController(), fenix: true);
  Get.lazyPut(() => ChatController(), fenix: true);
  Get.lazyPut(() => ProfileController(), fenix: true);
  //Chat
  /*  Get.lazyPut(() => ChatController(), fenix: true);

  //Driver
  Get.lazyPut(() => TrackParcelController(), fenix: true);
  //Parcel Owner
  Get.lazyPut(() => MyParcelController(), fenix: true);
  Get.lazyPut(() => RefundController(), fenix: true);

  //Profile
  Get.lazyPut(() => ProfileController(), fenix: true);
  Get.lazyPut(() => NavigationControllerMain(), fenix: true);

  //Parcel Owner Home
  Get.lazyPut(() => ParcelOwnerHomeController(), fenix: true);

  //Driver
  Get.lazyPut(() => ParcelController(), fenix: true);

  //Driver Home
  Get.lazyPut(() => DriverHomeController(), fenix: true);*/
}
