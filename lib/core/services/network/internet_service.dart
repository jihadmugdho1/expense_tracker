import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class InternetService extends GetxController with WidgetsBindingObserver {
  static InternetService get to => Get.find();

  final RxBool isConnected = true.obs;

  late StreamSubscription<List<ConnectivityResult>> _subscription;
  Timer? _retryTimer;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    _checkConnection();
    _subscription =
        Connectivity().onConnectivityChanged.listen(_onConnectivityChanged);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkConnection();
    }
  }

  void _onConnectivityChanged(List<ConnectivityResult> results) {
    if (results.isEmpty || results.every((r) => r == ConnectivityResult.none)) {
      isConnected.value = false;
      _startRetryTimer();
    } else {
      _verifyInternet();
    }
  }

  // Periodically re-check while offline — Android emulator often misses stream events
  void _startRetryTimer() {
    _retryTimer?.cancel();
    _retryTimer = Timer.periodic(const Duration(seconds: 3), (_) async {
      await _checkConnection();
      if (isConnected.value) {
        _retryTimer?.cancel();
        _retryTimer = null;
      }
    });
  }

  Future<void> _verifyInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com')
          .timeout(const Duration(seconds: 5));
      isConnected.value =
          result.isNotEmpty && result.first.rawAddress.isNotEmpty;
      if (!isConnected.value) _startRetryTimer();
    } catch (_) {
      isConnected.value = false;
      _startRetryTimer();
    }
  }

  Future<void> _checkConnection() async {
    final results = await Connectivity().checkConnectivity();
    if (results.every((r) => r == ConnectivityResult.none)) {
      isConnected.value = false;
      _startRetryTimer();
    } else {
      await _verifyInternet();
    }
  }

  Future<void> retry() => _checkConnection();

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    _subscription.cancel();
    _retryTimer?.cancel();
    super.onClose();
  }
}
