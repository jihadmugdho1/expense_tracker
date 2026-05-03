import 'dart:async';

import 'package:get/get.dart';
import 'package:petzy_optimized/routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    Timer(const Duration(seconds: 2), () {
      Get.offAllNamed(AppRoute.getBottomNavScreen());
    });
  }
}
