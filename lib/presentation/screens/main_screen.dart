import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:vpn_test_task/controllers/main_controller.dart';
import 'package:vpn_test_task/core/utils/app_assets.dart';

class MainScreen extends GetView<MainController> {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
      bottomNavigationBar: Obx(
        () => BottomAppBar(
          height: 90,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8, left: 16, right: 16),
                child: Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.grey.shade300,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(width: 10),
                  _buildNavItem(AppAssets.homeIcon, "Home", 0, context),
                  _buildNavItem(AppAssets.notificationIcon, "Notification", 1, context,),
                  _buildNavItem(AppAssets.connectIcon, "Services", 2, context),
                  _buildNavItem(AppAssets.settingsIcon, "Settings", 3, context,),
                  SizedBox(width: 10),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox _buildNavItem(
    iconPath,
    String label,
    int index,
    BuildContext context,
  ) {
    final bool isSelected = controller.selectedIndex.value == index;
    final color =
        isSelected
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.primary.withValues(alpha: 0.5);

    return SizedBox(
      height: 50,
      width: 50,
      child: InkWell(
        onTap: () => controller.selectedIndex.value = index,
        borderRadius: BorderRadius.circular(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconPath,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
              width: 20,
              height: 20,
            ),
            Text(label, style: Theme.of(context).textTheme.labelSmall, maxLines: 1,),
          ],
        ),
      ),
    );
  }
}
