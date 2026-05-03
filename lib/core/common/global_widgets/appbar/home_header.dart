import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:petzy_optimized/core/utils/constants/colors.dart';

import '../common_button/small_button/small_button.dart';
import '../searchbar/searchbar.dart';

class ProHomeHeader extends StatelessWidget implements PreferredSizeWidget {
  final bool isGuest;
  final TextEditingController? controller;

  final VoidCallback? onMenuTap;
  final VoidCallback? onLoginTap;
  final VoidCallback? onScanTap;
  final VoidCallback? onNotificationTap;

  const ProHomeHeader({
    super.key,
    required this.isGuest,
    this.controller,
    this.onMenuTap,
    this.onLoginTap,
    this.onScanTap,
    this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = AppColors.textPrimary(context);

    return AppBar(
      backgroundColor: AppColors.background(context),
      elevation: 0,
      automaticallyImplyLeading: false,

      title: Row(
        children: [
          IconButton(
            icon: Icon(Icons.menu, color: textColor),
            onPressed: onMenuTap,
          ),

          /// 🔍 Search Bar
          Expanded(
            child: ProSearchBar(
              controller: controller,
              hintText: "Search here",
              borderRadius: 10,
            ),
          ),

          const SizedBox(width: 8),

          /// 👉 Right Side Condition
          if (isGuest)
            IconTextButton(text: 'Login', onTap: () {})
          else
            _buildActions(context),
        ],
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    final textColor = AppColors.textPrimary(context);

    return Row(
      children: [
        IconButton(
          icon: Icon(LucideIcons.scanLine, color: textColor),
          onPressed: onScanTap,
        ),
        Stack(
          children: [
            IconButton(
              icon: Icon(Iconsax.notification, color: textColor),
              onPressed: onNotificationTap,
            ),

            Positioned(
              right: 15,
              top: 15,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.error,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
