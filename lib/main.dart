import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vpn_test_task/bindings/main_binding.dart';
import 'package:vpn_test_task/controllers/onboarding_controller.dart';
import 'package:vpn_test_task/core/theme/app_theme.dart';
import 'package:vpn_test_task/routes/app_pages.dart';

import 'routes/app_routes.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final onboardingController = OnboardingController();

    return GetMaterialApp(
      title: 'NAME VPN',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: onboardingController.isOnboardingComplete
          ? AppRoutes.main
          : AppRoutes.onboarding,
      getPages: AppPages.routes,
      initialBinding: MainBinding(),
    );
  }
}
