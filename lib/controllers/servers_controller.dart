import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_test_task/core/utils/app_assets.dart';
import 'package:vpn_test_task/data/models/server_model.dart';

class ServersController extends GetxController {
  List<ServerModel> _masterServerList = [];

  final RxList<ServerModel> unlockedServers = <ServerModel>[].obs;
  final RxList<ServerModel> lockedServers = <ServerModel>[].obs;
  final Rx<ServerModel?> selectedServer = Rx<ServerModel?>(null);

  final RxString searchQuery = ''.obs;
  final TextEditingController searchTextController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    _loadServers();
    debounce(searchQuery, (String query) => _performSearch(query),
        time: const Duration(milliseconds: 300));
    _performSearch('');
  }

  void _loadServers() {
    final tempAllServers = [
      ServerModel(id: 'af1', name: 'Afghanistan', flagAsset: AppAssets.afFlag, countryCode: 'af', ipAddress: '88.123.45.67', isPremium: false),
      ServerModel(id: 'us1', name: 'USA', flagAsset: AppAssets.usFlag, countryCode: 'us', ipAddress: '102.55.77.88', isPremium: false),
      ServerModel(id: 'ir1', name: 'Iran', flagAsset: AppAssets.irFlag, countryCode: 'ir', ipAddress: '10.0.0.1', isPremium: false),
      ServerModel(id: 'pk1', name: 'Pakistan', flagAsset: AppAssets.pkFlag, countryCode: 'pk', ipAddress: '10.0.0.2', isPremium: false),
      ServerModel(id: 'in1', name: 'India', flagAsset: AppAssets.inFlag, countryCode: 'in', ipAddress: '10.0.0.3', isPremium: false),
      ServerModel(id: 'nl1', name: 'Netherlands', flagAsset: AppAssets.nlFlag, countryCode: 'nl', ipAddress: '10.0.0.4', isPremium: true),
      ServerModel(id: 'eg1', name: 'Egypt', flagAsset: AppAssets.egFlag, countryCode: 'eg', ipAddress: '10.0.0.5', isPremium: true),
      ServerModel(id: 'ca1', name: 'Canada', flagAsset: AppAssets.caFlag, countryCode: 'ca', ipAddress: '10.0.0.6', isPremium: true),
      ServerModel(id: 'au1', name: 'Australia', flagAsset: AppAssets.auFlag, countryCode: 'au', ipAddress: '10.0.0.7', isPremium: true),
    ];
    _masterServerList = List.from(tempAllServers);

    final availableServers = _masterServerList.where((s) => !s.isPremium).toList();
    if (availableServers.isNotEmpty) {
      if (selectedServer.value == null) {
        selectedServer.value = availableServers.first;
      }
    }
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  void _performSearch(String query) {
    final lowerCaseQuery = query.toLowerCase();
    List<ServerModel> filteredUnlocked = [];
    List<ServerModel> filteredLocked = [];

    if (lowerCaseQuery.isEmpty) {
      filteredUnlocked = _masterServerList.where((s) => !s.isPremium).toList();
      filteredLocked = _masterServerList.where((s) => s.isPremium).toList();
    } else {
      filteredUnlocked = _masterServerList
          .where((s) =>
      !s.isPremium && s.name.toLowerCase().contains(lowerCaseQuery))
          .toList();
      filteredLocked = _masterServerList
          .where((s) =>
      s.isPremium && s.name.toLowerCase().contains(lowerCaseQuery))
          .toList();
    }

    unlockedServers.assignAll(filteredUnlocked);
    lockedServers.assignAll(filteredLocked);
  }

  void selectServer(ServerModel server) {
    if (!server.isPremium) {
      selectedServer.value = server;
      Get.snackbar(
        "Server has been selected",
        "Selected server: ${server.name}",
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    } else {
      Get.snackbar(
        "The server is blocked",
        "${server.name} is a premium server. Please choose another one.",
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    }
  }

  void clearSearchQuery() {
    searchTextController.clear();
    searchQuery.value = '';
  }

  @override
  void onClose() {
    searchTextController.dispose();
    super.onClose();
  }
}