import 'package:flutter/material.dart';
import 'package:petzy_optimized/core/utils/constants/colors.dart';

class ProTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;

  final bool? obscureText;
  final bool ?readOnly;
  final int ? maxLines;

  final Widget? prefixIcon;
  final Widget? suffixIcon;

  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final VoidCallback? onTap;

  final Color? fillColor;
  final Color? borderColor;
  final double? borderRadius;

  const ProTextField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,

    this.obscureText = false,
    this.readOnly = false,
    this.maxLines = 1,

    this.prefixIcon,
    this.suffixIcon,

    this.keyboardType,
    this.validator,
    this.onChanged,
    this.onTap,

    this.fillColor,
    this.borderColor,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius ?? 12),
      borderSide: BorderSide(color: borderColor ?? AppColors.border(context)),
    );

    return TextFormField(
      controller: controller,
      obscureText: obscureText?? false,
      readOnly: readOnly?? false,
      maxLines: (obscureText ?? false) ? 1 : (maxLines ?? 1),
      keyboardType: keyboardType,
      validator: validator,
      onChanged: onChanged,
      onTap: onTap,

      decoration: InputDecoration(
        hintText: hintText ?? "Enter text",
        labelText: labelText,
        filled: true,
        fillColor: fillColor ?? AppColors.background(context),

        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,

        border: border,
        enabledBorder: border,
        focusedBorder: border.copyWith(
          borderSide: BorderSide(
            color: borderColor ?? AppColors.primary,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
