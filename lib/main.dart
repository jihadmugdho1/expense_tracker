import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app.dart';
import 'core/controllers/theme_controller.dart';
import 'core/services/cache/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Needed before any token-based network/storage access.
  await StorageService.init();

  Get.put<ThemeController>(ThemeController(), permanent: true);

  runApp(const MyApp());
}
