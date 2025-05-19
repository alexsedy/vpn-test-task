import 'dart:async';
import 'dart:math';

import 'package:get/get.dart';
import 'package:vpn_test_task/controllers/main_controller.dart';
import 'package:vpn_test_task/controllers/servers_controller.dart';

enum ConnectionStatus {
  disconnected,
  connecting,
  connected,
}

class ConnectivityController extends GetxController {
  final MainController _mainController = Get.find<MainController>();
  final Rx<ConnectionStatus> connectionState = ConnectionStatus.disconnected.obs;
  final RxString statusText = "Not connected".obs;
  final RxString connectingTime = "00:00:00".obs;

  final RxString downloadSpeed = "0.0 Mbps".obs;
  final RxString uploadSpeed = "0.0 Mbps".obs;

  Timer? _timer;
  int _secondsElapsed = 0;

  Timer? _speedSimulationTimer;
  final Random _random = Random();

  final ServersController serversController = Get.find<ServersController>();

  void toggleConnection() {
    if (connectionState.value == ConnectionStatus.connected) {
      _disconnect();
    } else if (connectionState.value == ConnectionStatus.disconnected) {
      _connect();
    }
  }

  void _connect() async {
    connectionState.value = ConnectionStatus.connecting;
    statusText.value = "Connecting...";

    await Future.delayed(const Duration(seconds: 2));

    if (connectionState.value == ConnectionStatus.connecting) {
      connectionState.value = ConnectionStatus.connected;
      statusText.value = "Connected";
      _startTimer();
      _startSpeedSimulation();
    }
  }

  void _disconnect() {
    connectionState.value = ConnectionStatus.disconnected;
    statusText.value = "Disconnect";
    _stopTimer();
    _stopSpeedSimulation();
    connectingTime.value = "00:00:00";
    downloadSpeed.value = "0.0 Mbps";
    uploadSpeed.value = "0.0 Mbps";
  }

  void _startTimer() {
    _secondsElapsed = 0;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _secondsElapsed++;
      int hours = _secondsElapsed ~/ 3600;
      int minutes = (_secondsElapsed % 3600) ~/ 60;
      int seconds = _secondsElapsed % 60;
      connectingTime.value =
      "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  void _startSpeedSimulation() {
    _speedSimulationTimer?.cancel();
    _speedSimulationTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (connectionState.value == ConnectionStatus.connected) {
        double dlSpeed = 0.5 + _random.nextDouble() * 4.5;
        double ulSpeed = 0.3 + _random.nextDouble() * 3.7;
        downloadSpeed.value = "${dlSpeed.toStringAsFixed(1)} Mbps";
        uploadSpeed.value = "${ulSpeed.toStringAsFixed(1)} Mbps";
      } else {
        _stopSpeedSimulation();
      }
    });
  }

  void _stopSpeedSimulation() {
    _speedSimulationTimer?.cancel();
  }

  @override
  void onClose() {
    _timer?.cancel();
    _speedSimulationTimer?.cancel();
    super.onClose();
  }

  void navigateToServicesTab() {
    _mainController.changeTabIndex(2);
  }
}