import 'dart:async';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
class NetworkController extends GetxController {
  final isConnected = true.obs;
  late StreamSubscription<List<ConnectivityResult>> _subscription;

  @override
  void onInit() {
    super.onInit();
    _checkConnectivity();
    _subscription = Connectivity().onConnectivityChanged.listen((result) {
      isConnected.value = (result.isNotEmpty && result.first != ConnectivityResult.none);
    });
  }

  Future<void> _checkConnectivity() async {
    final result = await Connectivity().checkConnectivity();
    isConnected.value = (result != ConnectivityResult.none);
  }

  Future<void> checkConnection() async {
    await _checkConnectivity();
  }

  @override
  void onClose() {
    _subscription.cancel();
    super.onClose();
  }
}
