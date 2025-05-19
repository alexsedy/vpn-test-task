import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_test_task/controllers/onboarding_controller.dart';
import 'package:vpn_test_task/core/utils/app_assets.dart';

class OnboardingScreen extends GetView<OnboardingController> {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Spacer(flex: 2),
              Row(
                children: [
                  const Spacer(flex: 115),
                  Expanded(
                    flex: 253,
                    child: Image.asset(
                      AppAssets.rocketImage,
                      height: MediaQuery.of(context).size.height * 0.4,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.rocket_launch,),
                    ),
                  ),
                  const Spacer(flex: 72),
                ],
              ),
              const Spacer(flex: 1),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  "Enjoy fast and secure your connection everywhere",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              const Spacer(flex: 1),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width  * (150 / 440),
                  child: Flexible(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        controller.completeOnboarding();
                      },
                      child: Text(
                        "Start",
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
