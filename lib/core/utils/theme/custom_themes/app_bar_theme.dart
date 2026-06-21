import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:expensetracker/core/common/styles/global_text_style.dart';

import '../../constants/colors.dart';

class AppBarThemes {
  AppBarThemes._();

  static final AppBarTheme lightAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: true,
    foregroundColor: AppColors.lightTextPrimary,
    backgroundColor: AppColors.lightBackground,
    surfaceTintColor: AppColors.transparent,
    iconTheme: IconThemeData(color: AppColors.lightTextPrimary),
    actionsIconTheme: IconThemeData(color: AppColors.lightTextPrimary),
    titleTextStyle: AppTextStyle().semiBoldTextStyle(
      color: AppColors.lightTextPrimary,
      fontSize: AppTextStyle.xxl,
    ),
    systemOverlayStyle: SystemUiOverlayStyle.dark,
  );

  static final AppBarTheme darkAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: true,
    foregroundColor: AppColors.darkTextPrimary,
    backgroundColor: AppColors.darkBackground,
    surfaceTintColor: AppColors.transparent,
    iconTheme: IconThemeData(color: AppColors.darkTextPrimary),
    actionsIconTheme: IconThemeData(color: AppColors.darkTextPrimary),
    titleTextStyle: AppTextStyle().semiBoldTextStyle(
      color: AppColors.darkTextPrimary,
      fontSize: AppTextStyle.xxl,
    ),
    systemOverlayStyle: SystemUiOverlayStyle.light,
  );
}
