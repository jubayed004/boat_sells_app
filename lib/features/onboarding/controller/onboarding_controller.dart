import 'package:boat_sells_app/features/onboarding/model/onboarding_model.dart';
import 'package:boat_sells_app/utils/app_strings/app_strings.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  RxInt currentIndex = 0.obs;

  final List<OnboardingModel> onboardingList = [
    OnboardingModel(
      image: "assets/images/onbordingimage.png",
      title: AppStrings.onboardingOne.tr,
      details: AppStrings.onboardingSubtitle.tr,
    ),

    OnboardingModel(
      image: "assets/images/onboardingoneimageone.png",
      title: AppStrings.onboardingTwo.tr,
      details: AppStrings.onboardingSubtitleTwo.tr,
    ),

    OnboardingModel(
      image: "assets/images/onboardingimagetwo.png",
      title: AppStrings.onboardingThree.tr,
      details: AppStrings.onboardingSubtitleThree.tr,
    ),
  ];
}
