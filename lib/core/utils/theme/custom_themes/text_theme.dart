import 'package:flutter/material.dart';
import 'package:petzy_optimized/core/common/styles/global_text_style.dart';

import '../../constants/colors.dart';

class AppTextTheme {
  AppTextTheme._();

  static TextTheme _build({
    required Color primary,
    required Color secondary,
    required Color disabled,
  }) {
    final appTextStyle = AppTextStyle();

    return TextTheme(
      displayLarge: appTextStyle.boldTextStyle(fontSize: 57, color: primary),
      displayMedium: appTextStyle.semiBoldTextStyle(
        fontSize: 45,
        color: primary,
      ),
      displaySmall: appTextStyle.mediumTextStyle(fontSize: 36, color: primary),
      headlineLarge: appTextStyle.boldTextStyle(fontSize: 32, color: primary),
      headlineMedium: appTextStyle.semiBoldTextStyle(
        fontSize: 28,
        color: primary,
      ),
      headlineSmall: appTextStyle.mediumTextStyle(fontSize: 24, color: primary),
      titleLarge: appTextStyle.semiBoldTextStyle(fontSize: 22, color: primary),
      titleMedium: appTextStyle.mediumTextStyle(
        fontSize: AppTextStyle.lg,
        color: primary,
      ),
      titleSmall: appTextStyle.mediumTextStyle(
        fontSize: AppTextStyle.md,
        color: secondary,
      ),
      bodyLarge: appTextStyle.regularTextStyle(
        fontSize: AppTextStyle.lg,
        color: primary,
      ),
      bodyMedium: appTextStyle.regularTextStyle(
        fontSize: AppTextStyle.md,
        color: secondary,
      ),
      bodySmall: appTextStyle.regularTextStyle(
        fontSize: AppTextStyle.sm,
        color: secondary,
      ),
      labelLarge: appTextStyle.semiBoldTextStyle(
        fontSize: AppTextStyle.md,
        color: primary,
      ),
      labelMedium: appTextStyle.mediumTextStyle(
        fontSize: AppTextStyle.sm,
        color: secondary,
      ),
      labelSmall: appTextStyle.mediumTextStyle(fontSize: 11, color: disabled),
    );
  }

  static final TextTheme lightTextTheme = _build(
    primary: AppColors.lightTextPrimary,
    secondary: AppColors.lightTextSecondary,
    disabled: AppColors.lightTextDisabled,
  );

  static final TextTheme darkTextTheme = _build(
    primary: AppColors.darkTextPrimary,
    secondary: AppColors.darkTextSecondary,
    disabled: AppColors.darkTextDisabled,
  );
}
