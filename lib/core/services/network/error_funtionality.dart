import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'internet_service.dart';

class InternetToastListener extends StatefulWidget {
  const InternetToastListener({super.key, required this.child});
  final Widget child;

  @override
  State<InternetToastListener> createState() => InternetToastListenerState();
}

class InternetToastListenerState extends State<InternetToastListener> {
  Worker? _worker;
  bool _isInitialCheck = true;

  @override
  void initState() {
    super.initState();
    // Listening to internet changes with a professional GetX Snackbar
    _worker = ever(InternetService.to.isConnected, (bool connected) {
      // Prevent showing "Connected" toast immediately when app starts
      if (_isInitialCheck) {
        _isInitialCheck = false;
        if (connected) return;
      }

      _showProfessionalToast(connected);
    });
  }

  void _showProfessionalToast(bool isConnected) {
    Get.rawSnackbar(
      animationDuration: Duration(seconds: 1),
      titleText: Text(
        isConnected ? 'Connection Restored' : 'No Internet Connection',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      messageText: Text(
        isConnected
            ? 'You are back online now.'
            : 'Please check your data or Wi-Fi settings.',
        style: const TextStyle(color: Colors.white70),
      ),
      icon: Icon(
        isConnected ? Icons.wifi_rounded : Icons.wifi_off_rounded,
        color: Colors.white,
        size: 28,
      ),
      backgroundColor: isConnected
          ? Colors.green.shade600
          : Colors.redAccent.shade700,
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(15),
      borderRadius: 12,
      snackStyle: SnackStyle.FLOATING,

      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.bounceIn,
    );
  }

  @override
  void dispose() {
    _worker?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
