import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../routes/app_pages.dart';

class OnboardingController extends GetxController {
  final GetStorage _storage = GetStorage();
  final String _onboardingCompleteKey = 'onboarding_complete';

  bool get isOnboardingComplete {
    return _storage.read<bool>(_onboardingCompleteKey) ?? false;
  }

  void completeOnboarding() {
    _storage.write(_onboardingCompleteKey, true);
    Get.offAllNamed(AppRoutes.main);
  }

  void resetOnboarding() {
    _storage.write(_onboardingCompleteKey, false);
  }
}