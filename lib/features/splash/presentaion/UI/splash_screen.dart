import 'package:flutter/material.dart';
import 'package:expensetracker/core/controllers/theme_controller.dart';
import 'package:expensetracker/core/core.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: themeController.isDarkMode
              ? AppColors.primaryDarkGradient
              : AppColors.primaryLightGradient,
        ),
        child: Column(
          children: [
            SizedBox(height: 180.h),
            Text(
              AppText.appName,
              style: AppTextStyle().boldTextStyle(
                fontSize: 48.sp,
                color: Colors.white,
              ),
            ),

            Text(
              AppText.appDescription,
              style: AppTextStyle().mediumTextStyle(
                fontSize: 16.sp,
                color: Colors.white,
              ),
            ),
            Spacer(),

            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 60.h),
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: Colors.white,
                  size: 40.w,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
