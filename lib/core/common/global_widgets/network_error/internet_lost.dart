import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:petzy_optimized/core/core.dart';

class InternetLost extends StatelessWidget {
  const InternetLost({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);

    return Scaffold(
      backgroundColor: isDark ? AppColors.black : AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.r),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 150.h,
                child: Lottie.asset(
                  'assets/jsons/paperplane.json',
                  fit: BoxFit.contain,
                ),
              ),
              Text(
                'No Internet Connection',
                style: AppTextStyle()
                    .getTextStyle(
                      fontSize: AppTextStyle.title,
                      color: AppColors.primary,
                    )
                    .copyWith(fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                'Looks like your device is offline.\nCheck your Wi-Fi or mobile data and try again.',
                style: AppTextStyle().getTextStyle(
                  color: isDark
                      ? AppColors.primarydark
                      : AppColors.lightTextPrimary,

                  fontSize: AppTextStyle.sm,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              GestureDetector(
                onTap: () => InternetService.to.retry(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Retry',
                      style: AppTextStyle().getTextStyle(
                        color: AppColors.primary,
                        fontSize: AppTextStyle.xl,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(Icons.replay_rounded, color: AppColors.primary),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
