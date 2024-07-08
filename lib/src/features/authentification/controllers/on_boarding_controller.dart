import 'package:get/get.dart';
import 'package:liquid_swipe/PageHelpers/LiquidController.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

import '../../../constants/colors.dart';
import '../../../constants/image_strings.dart';
import '../../../utils/translation/translation.dart';
import '../models/model_on_boarding.dart';
import '../screens/on_boarding/widgets/on_boarding_page_widget.dart';

class OnBoardingController extends GetxController {
  final controller = LiquidController();
  RxInt currentPage = 0.obs;

  final pages = [
    OnBoardingPageWidget(
      model: OnBoardingModel(
        image: onboardingImage1,
        title: tr('OnboardingTitle1'),
        subtitle: (tr('OnboardingSubtitle1')),
        counterText: tr('OnboardingCounter1'),
        bgColor: OnBoardingPage1Color,
      ),
    ),
    OnBoardingPageWidget(
      model: OnBoardingModel(
        image: onboardingImage2,
        title: tr('OnboardingTitle2'),
        subtitle: tr('OnboardingSubtitle2'),
        counterText: tr('OnboardingCounter2'),
        bgColor: OnBoardingPage2Color,
      ),
    ),
    OnBoardingPageWidget(
      model: OnBoardingModel(
        image: onboardingImage3,
        title: tr('OnboardingTitle3'),
        subtitle: tr('OnboardingSubtitle3'),
        counterText: tr('OnboardingCounter3'),
        bgColor: OnBoardingPage3Color,
      ),
    ),
  ];

  skip() => Get.offAllNamed('/welcome');

  animateToNextSlide() {
    int nextPage = controller.currentPage + 1;
    controller.animateToPage(page: nextPage);
  }

  onPageChangeCallback(int activePageIndex) =>
      currentPage.value = activePageIndex;
}
