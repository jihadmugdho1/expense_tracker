import 'package:flutter/material.dart';
import 'package:flutter_tamplate/core/common/styles/global_text_style.dart';

import '../../constants/colors.dart';

class AppElevatedButtonTheme {
  AppElevatedButtonTheme._();

  static final ElevatedButtonThemeData lightElevatedButtonTheme =
      ElevatedButtonThemeData(
        style: ButtonStyle(
          elevation: WidgetStateProperty.all(0),
          foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
            if (states.contains(WidgetState.disabled)) {
              return AppColors.lightTextDisabled;
            }
            return AppColors.white;
          }),
          backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
            if (states.contains(WidgetState.disabled)) {
              return AppColors.lightSurfaceVariant;
            }
            return AppColors.primary;
          }),
          side: WidgetStateProperty.all(
            const BorderSide(color: AppColors.primary),
          ),
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(vertical: 16),
          ),
          textStyle: WidgetStateProperty.all(
            AppTextStyle().semiBoldTextStyle(fontSize: AppTextStyle.lg),
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      );

  static final ElevatedButtonThemeData darkElevatedButtonTheme =
      ElevatedButtonThemeData(
        style: ButtonStyle(
          elevation: WidgetStateProperty.all(0),
          foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
            if (states.contains(WidgetState.disabled)) {
              return AppColors.darkTextDisabled;
            }
            return AppColors.white;
          }),
          backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
            if (states.contains(WidgetState.disabled)) {
              return AppColors.darkSurfaceVariant;
            }
            return AppColors.primary;
          }),
          side: WidgetStateProperty.all(
            const BorderSide(color: AppColors.primary),
          ),
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(vertical: 16),
          ),
          textStyle: WidgetStateProperty.all(
            AppTextStyle().semiBoldTextStyle(fontSize: AppTextStyle.lg),
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      );
}
