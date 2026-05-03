import 'package:flutter/material.dart';
import 'package:petzy_optimized/core/common/styles/global_text_style.dart';
import 'package:petzy_optimized/core/utils/constants/colors.dart';

class FilterButtonGroup extends StatelessWidget {
  final List<String> options;
  final int selectedIndex;
  final Function(int) onChanged;

  final bool isExpanded; // 🔥 NEW

  final Color? selectedColor;
  final Color? unselectedColor;
  final Color? textColor;
  final double borderRadius;

  const FilterButtonGroup({
    super.key,
    required this.options,
    required this.selectedIndex,
    required this.onChanged,
    this.isExpanded = true, // default = chip style
    this.selectedColor,
    this.unselectedColor,
    this.textColor,
    this.borderRadius = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: unselectedColor ?? AppColors.background(context),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Row(
          children: List.generate(options.length, (index) {
            final bool isSelected = index == selectedIndex;
      
            final button = GestureDetector(
              onTap: () => onChanged(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: isExpanded ? double.infinity : null, // 🔥 key logic
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 14,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? (selectedColor ?? AppColors.primary)
                      : AppColors.transparent,
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                child: Center(
                  child: Text(
                    options[index],
                    style: AppTextStyle(context).getTextStyle(
                      color: isSelected
                          ? (textColor ?? AppColors.white)
                          : AppColors.textPrimary(context),
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
            );
      
            return isExpanded
                ? Expanded(child: button) // 🔥 equal width mode
                : button; // 🔥 chip mode
          }),
        ),
      ),
    );
  }
}