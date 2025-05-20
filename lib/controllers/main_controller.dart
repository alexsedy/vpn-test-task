import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_test_task/presentation/screens/connectivity_screen.dart';
import 'package:vpn_test_task/presentation/screens/notification_screen.dart';
import 'package:vpn_test_task/presentation/screens/servers_screen.dart';
import 'package:vpn_test_task/presentation/screens/settings_screen.dart';

class MainController extends GetxController {
  final RxInt selectedIndex = 0.obs;

  final List<Widget> screens = [
    const ConnectivityScreen(),
    const NotificationScreen(),
    const ServersScreen(),
    const SettingsScreen(),
  ];

  void changeTabIndex(int index) {
    if (selectedIndex.value == index) return;
    selectedIndex.value = index;
  }
}
