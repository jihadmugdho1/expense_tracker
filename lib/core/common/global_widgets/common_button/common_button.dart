import 'package:flutter/material.dart';
import 'package:petzy_optimized/core/common/styles/global_text_style.dart';
import 'package:petzy_optimized/core/utils/constants/colors.dart';

class ProElevatedButton extends StatelessWidget {
  // ACTION
  final VoidCallback? onPressed;

  // CONTENT
  final String? text;
  final Widget? child;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final double? iconSize;
  final double? fontWeight;
  final double? iconWeight;

  // STATES
  final bool isLoading;
  final bool isDisabled;

  // STYLE
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? textColor;
  final Color? iconColor;
  final Gradient? gradient;
  final BorderSide? border;

  // SIZE
  final double? width;
  final double height;
  final double borderRadius;
  final EdgeInsetsGeometry padding;

  // TEXT STYLE
  final double? fontSize;
  final TextStyle? textStyle;

  const ProElevatedButton({
    this.fontWeight,
    this.iconWeight,
    super.key,
    this.text,
    this.onPressed,
    this.child,
    this.leadingIcon,
    this.trailingIcon,
    this.iconSize,
    this.isLoading = false,
    this.isDisabled = false,
    this.backgroundColor,
    this.foregroundColor,
    this.textColor,
    this.iconColor,
    this.gradient,
    this.border,
    this.width,
    this.height = 55,
    this.borderRadius = 12,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
    this.fontSize,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final bool disabled = isDisabled || isLoading;
    final Color bgColor = backgroundColor ?? AppColors.primary;
    final Color fgColor = textColor ?? AppColors.white;
    final Color icColor = iconColor ?? fgColor;
    final double icSize = iconSize ?? 20;

    Widget content;

    if (isLoading) {
      content = SizedBox(
        height: 22,
        width: 22,
        child: CircularProgressIndicator(strokeWidth: 2, color: fgColor),
      );
    } else if (child != null) {
      content = child!;
    } else {
      final hasText = text != null && text!.isNotEmpty;
      final hasLeading = leadingIcon != null;
      final hasTrailing = trailingIcon != null;

      content = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (hasLeading) ...[
            Icon(leadingIcon, size: icSize, color: icColor),
            if (hasText) const SizedBox(width: 8),
          ],
          if (hasText)
            Text(
              text!,
              style:
                  textStyle ??
                  AppTextStyle(context).semiBoldTextStyle(
                    fontSize: fontSize ?? AppTextStyle.lg,
                    color: fgColor,
                  ),
            ),
          if (hasTrailing) ...[
            if (hasText) const SizedBox(width: 8),
            Icon(trailingIcon, size: icSize, color: icColor),
          ],
        ],
      );
    }

    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: disabled ? null : (onPressed ?? () {}),
        style: ElevatedButton.styleFrom(
          backgroundColor: gradient == null ? bgColor : AppColors.primary,
          foregroundColor: foregroundColor ?? fgColor,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: border ?? BorderSide.none,
          ),
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(borderRadius),
            color: gradient == null ? bgColor : null,
          ),
          child: Padding(
            padding: padding,
            child: Center(child: content),
          ),
        ),
      ),
    );
  }
}
