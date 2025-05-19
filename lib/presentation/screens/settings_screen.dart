import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:vpn_test_task/controllers/settings_controller.dart';
import 'package:vpn_test_task/core/utils/app_assets.dart';

class SettingsScreen extends GetView<SettingsController> {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', style: Theme.of(context).textTheme.headlineMedium),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Obx(() => _SettingItemWithSwitch(
            iconAsset: AppAssets.autoConnectIcon,
            title: "Auto-connect",
            value: controller.autoConnect.value,
            onChanged: controller.toggleAutoConnect,
          )),
          Obx(() => _SettingItemWithSwitch(
            iconAsset: AppAssets.killSwitchIcon,
            title: "Kill Switch",
            subtitle: "Automatically disconnects your device from the internet",
            value: controller.killSwitch.value,
            onChanged: controller.toggleKillSwitch,
          )),
          Obx(() => _SettingItemWithSwitch(
            iconAsset: AppAssets.stealthModeIcon,
            title: "Stealth Mode",
            subtitle: "Additional level of traffic masking",
            value: controller.stealthMode.value,
            onChanged: controller.toggleStealthMode,
          )),
          Obx(() => _SettingItemWithSwitch(
            iconAsset: AppAssets.noAdsIcon,
            title: "No-Ads",
            subtitle: "Turn off advertisements",
            value: controller.noAds.value,
            onChanged: controller.toggleNoAds,
          )),
          _SettingItemWithTile(
            iconAsset: AppAssets.dnsIcon,
            title: "Choose DNS",
            onTap: controller.chooseDns,
          ),
          const SizedBox(height: 20),
          _SettingItem(
            iconAsset: AppAssets.feedbackIcon,
            title: "Feedback",
            onTap: controller.openFeedback,
          ),
          _SettingItem(
            iconAsset: AppAssets.rateAppIcon,
            title: "Rate App",
            onTap: controller.rateApp,
          ),
          _SettingItem(
            iconAsset: AppAssets.shareAppIcon,
            title: "Share App",
            onTap: controller.shareApp,
          ),
          _SettingItem(
            iconAsset: AppAssets.aboutAppIcon,
            title: "About App",
            onTap: controller.openAboutApp,
          ),
        ],
      ),
    );
  }
}

class _SettingItemWithSwitch extends StatelessWidget {
  final String iconAsset;
  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SettingItemWithSwitch({
    super.key,
    required this.iconAsset,
    required this.title,
    this.subtitle,
    required this.value,
    required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: SwitchListTile(
        secondary: SvgPicture.asset(
            iconAsset,
            colorFilter: ColorFilter.mode(
              Theme.of(context).colorScheme.primary,
              BlendMode.srcIn,
            ),
            width: 24, height: 24),
        title: Text(title, style: textTheme.titleSmall),
        subtitle: subtitle != null ? Text(subtitle!, style: textTheme.labelSmall) : null,
        value: value,
        onChanged: onChanged,
        activeColor: Theme.of(context).primaryColor,
      ),
    );
  }
}

class _SettingItem extends StatelessWidget {
  final String iconAsset;
  final String title;
  final VoidCallback onTap;

  const _SettingItem({
    super.key,
    required this.iconAsset,
    required this.title,
    required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Row(
        spacing: 20,
        children: [
          SizedBox(
            height: 24,
            width: 24,
            child: SvgPicture.asset(
              iconAsset,
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.primary,
                BlendMode.srcIn,
              ),
              width: 24,
              height: 24,
            ),
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingItemWithTile extends StatelessWidget {
  final String iconAsset;
  final String title;
  final VoidCallback onTap;

  const _SettingItemWithTile({
    super.key,
    required this.iconAsset,
    required this.title,
    required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: ListTile(
      leading: SvgPicture.asset(
          iconAsset,
          colorFilter: ColorFilter.mode(
            Theme.of(context).colorScheme.primary,
            BlendMode.srcIn,
          ),
          width: 24,
          height: 24,
        ),
        title: Text(title, style: Theme.of(context).textTheme.titleSmall),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
