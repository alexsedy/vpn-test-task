import 'package:get/get.dart';
import 'package:vpn_test_task/controllers/connectivity_controller.dart';
import 'package:vpn_test_task/controllers/main_controller.dart';
import 'package:vpn_test_task/controllers/onboarding_controller.dart';
import 'package:vpn_test_task/controllers/servers_controller.dart';
import 'package:vpn_test_task/controllers/settings_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(() => MainController());
    Get.lazyPut<ConnectivityController>(() => ConnectivityController());
    Get.lazyPut<ServersController>(() => ServersController());
    Get.lazyPut<SettingsController>(() => SettingsController());
    //todo remove the binding
    Get.lazyPut<OnboardingController>(() => OnboardingController());
  }
}
