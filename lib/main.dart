import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app.dart';
import 'core/controllers/theme_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put<ThemeController>(ThemeController(), permanent: true);

  runApp(const MyApp());
}
