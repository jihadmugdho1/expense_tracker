import 'package:flutter/material.dart';
import 'package:petzy_optimized/core/common/styles/global_text_style.dart';
import 'package:petzy_optimized/core/utils/constants/colors.dart';

class ProAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? titleWidget;

  final bool centerTitle;
  final bool showBackButton;
  final VoidCallback? onBackPressed;

  final List<Widget>? actions;

  final Color? backgroundColor;
  final Color? foregroundColor;
  final double elevation;

  const ProAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.centerTitle = true,
    this.showBackButton = true,
    this.onBackPressed,
    this.actions,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation = 0,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,

      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed:
                  onBackPressed ??
                  () {
                    Navigator.pop(context);
                  },
            )
          : null,

      title:
          titleWidget ??
          Text(
            title ?? "",
            style: AppTextStyle(context).semiBoldTextStyle(
              fontSize: AppTextStyle.xxl,
              color: foregroundColor ?? AppColors.textPrimary(context),
            ),
          ),

      centerTitle: centerTitle,

      actions: actions,

      backgroundColor: backgroundColor ?? AppColors.background(context),
      foregroundColor: foregroundColor ?? AppColors.textPrimary(context),
      elevation: elevation,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
