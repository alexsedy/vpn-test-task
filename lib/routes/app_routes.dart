import 'package:get/get.dart';
import 'package:vpn_test_task/bindings/main_binding.dart';
import 'package:vpn_test_task/controllers/onboarding_controller.dart';
import 'package:vpn_test_task/presentation/screens/main_screen.dart';
import 'package:vpn_test_task/presentation/screens/onboarding_screen.dart';
import 'package:vpn_test_task/routes/app_pages.dart';

class AppPages {
  static final List<GetPage> routes = [
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<OnboardingController>(() => OnboardingController());
      }),
    ),
    GetPage(
      name: AppRoutes.main,
      page: () => const MainScreen(),
      binding: MainBinding(),
    ),
  ];
}