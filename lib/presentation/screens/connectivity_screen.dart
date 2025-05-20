import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:vpn_test_task/controllers/connectivity_controller.dart';
import 'package:vpn_test_task/core/utils/app_assets.dart';

class ConnectivityScreen extends GetView<ConnectivityController> {
  const ConnectivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text("NAME VPN", style: textTheme.headlineMedium,),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(() {
              final server = controller.getSelectedServer();
              if(server != null) {
                return Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    onTap: () => controller.navigateToServicesTab(),
                    leading: Image.asset(server.flagAsset, width: 32, height: 32),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          server.name,
                          style: textTheme.titleSmall,
                        ),
                        Text(
                          server.ipAddress ?? "",
                          style: textTheme.bodySmall,

                        )
                      ],
                    ),
                    trailing: Icon(Icons.arrow_forward_ios_outlined),
                  ),
                );
              } else {
                return Text('Select server');
              }
            }),
            const SizedBox(height: 20),
            Column(
              children: [
                Text("Connecting Time", style: textTheme.titleMedium),
                Obx(() => Text(
                  controller.connectingTime.value,
                  style: textTheme.headlineLarge,
                )),
              ],
            ),

            _ConnectionButtonWidget(),

            _SpeedInfoWidget(),

            Obx(() =>Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 6.0,
              children: [
                if(controller.connectionState.value == ConnectionStatus.connected)
                SvgPicture.asset(
                  AppAssets.connectedIcon,
                  colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.primary, BlendMode.srcIn),
                  width: 17,
                  height: 17,
                ),
                Text(
                  controller.statusText.value,
                  style: textTheme.titleMedium?.copyWith(
                    color: controller.connectionState.value == ConnectionStatus.connected
                        ? Theme.of(context).colorScheme.primary
                        : (controller.connectionState.value == ConnectionStatus.connecting
                        ? Theme.of(context).colorScheme.secondary
                        : Theme.of(context).colorScheme.primaryContainer),
                  ),
                ),
              ],
            )),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _ConnectionButtonWidget extends GetView<ConnectivityController> {
  const _ConnectionButtonWidget();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GestureDetector(
        onTap: controller.toggleConnection,
        child: Center(
          child: Stack(
            children: [
              if(controller.connectionState.value == ConnectionStatus.connecting)
                const SizedBox(
                  width: 192,
                  height: 192,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                ),
              ),
              ClipOval(
                child: SvgPicture.asset(
                  AppAssets.powerButtonIcon,
                  colorFilter: controller.connectionState.value == ConnectionStatus.connected
                      ? null
                      : ColorFilter.mode(
                          Theme.of(context).colorScheme.primaryContainer,
                          BlendMode.color,
                        ),
                  width: 192,
                  height: 192,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class _SpeedInfoWidget extends GetView<ConnectivityController> {
  const _SpeedInfoWidget();

  Widget _speedIndicator(BuildContext context, String iconAsset, String speed, String label, TextTheme textTheme, ColorScheme colorScheme) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(iconAsset, width: 28, height: 28, color: colorScheme.primary),
        const SizedBox(height: 6),
        Text(speed, style: textTheme.labelMedium),
        Text(label, style: textTheme.bodySmall),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Obx(() {
      Widget currentChild;
      if (controller.connectionState.value == ConnectionStatus.connected) {
        currentChild = Padding(
          key: const ValueKey('speedInfoRow'),
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _speedIndicator(
                context,
                AppAssets.downloadIcon,
                "${controller.downloadSpeed}",
                "Download",
                textTheme,
                colorScheme,
              ),
              Container(height: 50, width: 1, color: colorScheme.outlineVariant.withValues(alpha: 0.5)),
              _speedIndicator(
                context,
                AppAssets.uploadIcon,
                "${controller.uploadSpeed}",
                "Upload",
                textTheme,
                colorScheme,
              ),
            ],
          ),
        );
      } else {
        currentChild = const SizedBox.shrink(key: ValueKey('emptySpeedInfoSizedBox'));
      }

      return AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.9, end: 1.0).animate(
                  CurvedAnimation(parent: animation, curve: Curves.easeOutCubic)
              ),
              child: child,
            ),
          );
        },
        child: currentChild,
      );
    });
  }
}

