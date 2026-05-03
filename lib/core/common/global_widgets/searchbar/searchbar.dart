import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:petzy_optimized/core/common/styles/global_text_style.dart';
import 'package:petzy_optimized/core/utils/constants/colors.dart';

class ProSearchBar extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;

  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final VoidCallback? onClear;

  final bool enableBorder;

  final Widget? prefixIcon;
  final Widget? suffixIcon;

  final Color? fillColor;
  final Color? borderColor;
  final double borderRadius;

  final bool readOnly;

  const ProSearchBar({
    super.key,
    this.controller,
    this.hintText = "Search...",
    this.onChanged,
    this.onTap,
    this.onClear,
    this.prefixIcon,
    this.suffixIcon,
    this.fillColor,
    this.borderColor,
    this.readOnly = false,
    this.enableBorder = false,
    this.borderRadius = 10,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        color: fillColor ?? AppColors.lightSurfaceVariant,
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          onTap: onTap,
          readOnly: readOnly,

          decoration: InputDecoration(
            hintText: hintText,
            filled: false,
            hintStyle: AppTextStyle(
              context,
            ).regularTextStyle(color: AppColors.textSecondary(context).withValues(alpha: 0.40)),

            prefixIcon:
                prefixIcon ??
                Icon(LucideIcons.search, color: AppColors.textSecondary(context).withValues(alpha: 0.35)),

            suffixIcon:
                suffixIcon ??
                (controller != null
                    ? ValueListenableBuilder<TextEditingValue>(
                        valueListenable: controller!,
                        builder: (context, value, child) {
                          if (value.text.isEmpty) return const SizedBox();

                          return IconButton(
                            icon: Icon(
                              Icons.close,
                              color: AppColors.textSecondary(context),
                            ),
                            onPressed: onClear ?? () => controller!.clear(),
                          );
                        },
                      )
                    : null),

            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12, // 👈 reduce this
              vertical: 10,
            ),

            border: enableBorder
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                    borderSide: BorderSide(
                      color: borderColor ?? AppColors.border(context),
                    ),
                  )
                : InputBorder.none,

            enabledBorder: enableBorder
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                    borderSide: BorderSide(
                      color: borderColor ?? AppColors.border(context),
                    ),
                  )
                : InputBorder.none,

            focusedBorder: enableBorder
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                    borderSide: BorderSide(
                      color: borderColor ?? AppColors.primary,
                      width: 1.5,
                    ),
                  )
                : InputBorder.none,
          ),
        ),
      ),
    );
  }
}
