import 'package:flutter/material.dart';
import 'package:petzy_optimized/core/core.dart';

class IconTextButton extends StatelessWidget {
  final IconData? icon;
  final String? text;
  final VoidCallback? onTap;

  // Colors
  final Color? textColor;
  final Color? iconColor;
  final Color? backgroundColor;
  final Color? borderColor;

  // Size & style
  final double? height;
  final double? width;
  final double? iconSize;
  final double? fontSize;
  final double? fontWeight; // e.g. 400, 600, 700
  final double? iconWeight; // e.g. 400, 700 (Material Symbols)
  final double? borderRadius;
  final double? borderWidth;
  final EdgeInsetsGeometry? padding;

  const IconTextButton({
    super.key,
    this.icon,
    this.text,
    this.onTap,
    this.textColor,
    this.iconColor,
    this.backgroundColor,
    this.borderColor,
    this.height,
    this.width,
    this.iconSize,
    this.fontSize,
    this.fontWeight,
    this.iconWeight,
    this.borderRadius,
    this.borderWidth,
    this.padding,
  });

  FontWeight _resolveFontWeight(double? w) {
    if (w == null) return FontWeight.normal;
    if (w <= 100) return FontWeight.w100;
    if (w <= 200) return FontWeight.w200;
    if (w <= 300) return FontWeight.w300;
    if (w <= 400) return FontWeight.w400;
    if (w <= 500) return FontWeight.w500;
    if (w <= 600) return FontWeight.w600;
    if (w <= 700) return FontWeight.w700;
    if (w <= 800) return FontWeight.w800;
    return FontWeight.w900;
  }

  @override
  Widget build(BuildContext context) {
    final hasIcon = icon != null;
    final hasText = text != null && text!.isNotEmpty;
    final hasBorder = borderColor != null || borderWidth != null;

    return SizedBox(
      height: height ?? 32,
      width: width ?? 100,
      child: TextButton(
        style: TextButton.styleFrom(
          padding: padding ?? const EdgeInsets.symmetric(vertical: 6),
          backgroundColor: backgroundColor ?? AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8),
            side: hasBorder
                ? BorderSide(
                    color: borderColor ?? AppColors.primary,
                    width: borderWidth ?? 1,
                  )
                : BorderSide.none,
          ),
        ),
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (hasIcon)
              Icon(
                icon,
                size: iconSize ?? 16,
                color: iconColor ?? AppColors.white,
                weight: iconWeight,
              ),
            if (hasIcon && hasText) const SizedBox(width: 6),
            if (hasText)
              Text(
                text!,
                style: AppTextStyle().getTextStyle(
                  fontSize: fontSize ?? 10,
                  color: textColor ?? AppColors.white,
                ).copyWith(fontWeight: _resolveFontWeight(fontWeight)),
              ),
          ],
        ),
      ),
    );
  }
}
