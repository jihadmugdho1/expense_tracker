import 'package:flutter/material.dart';
import 'package:flutter_tamplate/core/common/styles/global_text_style.dart';

import '../../constants/colors.dart';

class AppTextFormFieldTheme {
  AppTextFormFieldTheme._();

  static const _radius = BorderRadius.all(Radius.circular(14));

  static final InputDecorationTheme lightInputDecorationTheme =
      InputDecorationTheme(
        errorMaxLines: 3,
        prefixIconColor: AppColors.lightTextSecondary,
        suffixIconColor: AppColors.lightTextSecondary,
        labelStyle: AppTextStyle().regularTextStyle(
          fontSize: AppTextStyle.md,
          color: AppColors.lightTextPrimary,
        ),
        hintStyle: AppTextStyle().regularTextStyle(
          fontSize: AppTextStyle.md,
          color: AppColors.lightTextSecondary,
        ),
        errorStyle: AppTextStyle().regularTextStyle(
          fontSize: AppTextStyle.sm,
          color: AppColors.error,
        ),
        floatingLabelStyle: AppTextStyle().regularTextStyle(
          color: AppColors.primary,
        ),
        border: OutlineInputBorder(
          borderRadius: _radius,
          borderSide: BorderSide(color: AppColors.lightBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: _radius,
          borderSide: BorderSide(color: AppColors.lightBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: _radius,
          borderSide: BorderSide(color: AppColors.primary, width: 1.4),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: _radius,
          borderSide: BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: _radius,
          borderSide: BorderSide(color: AppColors.error, width: 1.4),
        ),
      );

  static final InputDecorationTheme darkInputDecorationTheme =
      InputDecorationTheme(
        errorMaxLines: 3,
        prefixIconColor: AppColors.darkTextSecondary,
        suffixIconColor: AppColors.darkTextSecondary,
        labelStyle: AppTextStyle().regularTextStyle(
          fontSize: AppTextStyle.md,
          color: AppColors.darkTextPrimary,
        ),
        hintStyle: AppTextStyle().regularTextStyle(
          fontSize: AppTextStyle.md,
          color: AppColors.darkTextSecondary,
        ),
        errorStyle: AppTextStyle().regularTextStyle(
          fontSize: AppTextStyle.sm,
          color: AppColors.error,
        ),
        floatingLabelStyle: AppTextStyle().regularTextStyle(
          color: AppColors.primary,
        ),
        border: OutlineInputBorder(
          borderRadius: _radius,
          borderSide: BorderSide(color: AppColors.darkBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: _radius,
          borderSide: BorderSide(color: AppColors.darkBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: _radius,
          borderSide: BorderSide(color: AppColors.primary, width: 1.4),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: _radius,
          borderSide: BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: _radius,
          borderSide: BorderSide(color: AppColors.error, width: 1.4),
        ),
      );
}
