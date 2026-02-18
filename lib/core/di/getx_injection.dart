import 'package:boat_sells_app/share/controller/language_controller.dart';
import 'package:boat_sells_app/utils/common_controller/common_controller.dart';
import 'package:get/get.dart';


void initGetx() {
  //Auth
  Get.lazyPut(() => LanguageController(), fenix: true);
/*  Get.lazyPut(() => AuthController(), fenix: true);

  //Others
  Get.lazyPut(() => OtherController(), fenix: true);
  Get.lazyPut(() => OnboardingController(), fenix: true);*/
  Get.lazyPut(() => CommonController(), fenix: true);

  //Chat
/*  Get.lazyPut(() => ChatController(), fenix: true);

  //Driver
  Get.lazyPut(() => TrackParcelController(), fenix: true);
  //Parcel Owner
  Get.lazyPut(() => MyParcelController(), fenix: true);
  Get.lazyPut(() => RefundController(), fenix: true);

  //Profile
  Get.lazyPut(() => ProfileController(), fenix: true);

  //Parcel Owner Home
  Get.lazyPut(() => ParcelOwnerHomeController(), fenix: true);

  //Driver
  Get.lazyPut(() => ParcelController(), fenix: true);

  //Driver Home
  Get.lazyPut(() => DriverHomeController(), fenix: true);*/
}
