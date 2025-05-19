import 'package:get/get.dart';
import 'package:vpn_test_task/controllers/onboarding_controller.dart';

class SettingsController extends GetxController {
  final OnboardingController _onboardingController = Get.find<OnboardingController>();

  final RxBool autoConnect = false.obs;
  final RxBool killSwitch = false.obs;
  final RxBool stealthMode = false.obs;
  final RxBool noAds = false.obs;

  void toggleAutoConnect(bool value) => autoConnect.value = value;
  void toggleKillSwitch(bool value) => killSwitch.value = value;
  void toggleStealthMode(bool value) => stealthMode.value = value;
  void toggleNoAds(bool value) => noAds.value = value;

  void chooseDns() {
    Get.snackbar("Feature in progress", "Function is not implemented yet.");
  }
  void openFeedback() {
    Get.snackbar("Feature in progress", "Function is not implemented yet.");
  }
  void rateApp() {
    Get.snackbar("Feature in progress", "Function is not implemented yet.");
  }
  void shareApp() {
    Get.snackbar("Feature in progress", "Function is not implemented yet.");
  }
  void openAboutApp() {
    Get.snackbar("Onboarding reset", "Onboarding reset.");
    _onboardingController.resetOnboarding();
  }
}
