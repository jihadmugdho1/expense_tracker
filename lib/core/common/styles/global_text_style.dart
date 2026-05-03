import 'package:flutter/material.dart';
import 'package:petzy_optimized/core/utils/constants/colors.dart';
import 'package:petzy_optimized/core/utils/constants/sizer.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyle {
  final BuildContext? _context;

  AppTextStyle([this._context]);

  // Font size constants
  static const double xs = 10;
  static const double sm = 12;
  static const double md = 14;
  static const double lg = 16;
  static const double xl = 18;
  static const double xxl = 20;
  static const double title = 24;
  static const double heading = 28;
  static const double display = 32;

  Color get _color => _context != null
      ? AppColors.textPrimary(_context)
      : AppColors.lightTextPrimary;

  TextStyle getTextStyle({
    required double fontSize,
    Color? color,
    FontWeight fontWeight = FontWeight.w400,
    FontStyle fontStyle = FontStyle.normal,
    double? lineHeight,
    double? letterSpacing,
    double? wordSpacing,
    TextDecoration decoration = TextDecoration.none,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    TextBaseline? textBaseline,
  }) {
    return GoogleFonts.nunito(
      fontSize: fontSize.sp,
      color: color ?? _color,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      height: lineHeight != null && fontSize > 0 ? lineHeight / fontSize : null,
      letterSpacing: letterSpacing?.sp,
      wordSpacing: wordSpacing?.sp,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
      textBaseline: textBaseline,
    );
  }

  TextStyle thinTextStyle({
    double fontSize = AppTextStyle.md,
    Color? color,
    FontStyle fontStyle = FontStyle.normal,
    double? lineHeight,
    double? letterSpacing,
    double? wordSpacing,
    TextDecoration decoration = TextDecoration.none,
  }) =>
      getTextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: FontWeight.w100,
        fontStyle: fontStyle,
        lineHeight: lineHeight,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        decoration: decoration,
      );

  TextStyle extraLightTextStyle({
    double fontSize = AppTextStyle.md,
    Color? color,
    FontStyle fontStyle = FontStyle.normal,
    double? lineHeight,
    double? letterSpacing,
    double? wordSpacing,
    TextDecoration decoration = TextDecoration.none,
  }) =>
      getTextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: FontWeight.w200,
        fontStyle: fontStyle,
        lineHeight: lineHeight,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        decoration: decoration,
      );

  TextStyle lightTextStyle({
    double fontSize = AppTextStyle.md,
    Color? color,
    FontStyle fontStyle = FontStyle.normal,
    double? lineHeight,
    double? letterSpacing,
    double? wordSpacing,
    TextDecoration decoration = TextDecoration.none,
  }) =>
      getTextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: FontWeight.w300,
        fontStyle: fontStyle,
        lineHeight: lineHeight,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        decoration: decoration,
      );

  TextStyle regularTextStyle({
    double fontSize = AppTextStyle.md,
    Color? color,
    FontStyle fontStyle = FontStyle.normal,
    double? lineHeight,
    double? letterSpacing,
    double? wordSpacing,
    TextDecoration decoration = TextDecoration.none,
  }) =>
      getTextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: FontWeight.w400,
        fontStyle: fontStyle,
        lineHeight: lineHeight,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        decoration: decoration,
      );

  TextStyle mediumTextStyle({
    double fontSize = AppTextStyle.md,
    Color? color,
    FontStyle fontStyle = FontStyle.normal,
    double? lineHeight,
    double? letterSpacing,
    double? wordSpacing,
    TextDecoration decoration = TextDecoration.none,
  }) =>
      getTextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: FontWeight.w500,
        fontStyle: fontStyle,
        lineHeight: lineHeight,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        decoration: decoration,
      );

  TextStyle semiBoldTextStyle({
    double fontSize = AppTextStyle.lg,
    Color? color,
    FontStyle fontStyle = FontStyle.normal,
    double? lineHeight,
    double? letterSpacing,
    double? wordSpacing,
    TextDecoration decoration = TextDecoration.none,
  }) =>
      getTextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: FontWeight.w600,
        fontStyle: fontStyle,
        lineHeight: lineHeight,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        decoration: decoration,
      );

  TextStyle boldTextStyle({
    double fontSize = AppTextStyle.lg,
    Color? color,
    FontStyle fontStyle = FontStyle.normal,
    double? lineHeight,
    double? letterSpacing,
    double? wordSpacing,
    TextDecoration decoration = TextDecoration.none,
  }) =>
      getTextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: FontWeight.w700,
        fontStyle: fontStyle,
        lineHeight: lineHeight,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        decoration: decoration,
      );

  TextStyle extraBoldTextStyle({
    double fontSize = AppTextStyle.xl,
    Color? color,
    FontStyle fontStyle = FontStyle.normal,
    double? lineHeight,
    double? letterSpacing,
    double? wordSpacing,
    TextDecoration decoration = TextDecoration.none,
  }) =>
      getTextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: FontWeight.w800,
        fontStyle: fontStyle,
        lineHeight: lineHeight,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        decoration: decoration,
      );

  TextStyle blackTextStyle({
    double fontSize = AppTextStyle.xl,
    Color? color,
    FontStyle fontStyle = FontStyle.normal,
    double? lineHeight,
    double? letterSpacing,
    double? wordSpacing,
    TextDecoration decoration = TextDecoration.none,
  }) =>
      getTextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: FontWeight.w900,
        fontStyle: fontStyle,
        lineHeight: lineHeight,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        decoration: decoration,
      );
}
