import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/bindings/controller_binder.dart';
import 'core/common/global_widgets/network_error/internet_lost.dart';
import 'core/controllers/theme_controller.dart';
import 'core/services/network/internet_service.dart';
import 'core/utils/constants/sizer.dart';
import 'core/utils/theme/theme.dart';
import 'routes/app_routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, screenType) {
        return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: AppRoute.getSplashScreen(),
            getPages: AppRoute.routes,
            initialBinding: ControllerBinder(),
            themeMode: ThemeController.to.themeMode,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            builder: (context, child) {
              final scaled = MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(textScaler: const TextScaler.linear(1.0)),
                child: child!,
              );
              return Obx(() {
                if (!InternetService.to.isConnected.value) {
                  return const InternetLost();
                }
                return scaled;
              });
            },
          );
      },
    );
  }
}
