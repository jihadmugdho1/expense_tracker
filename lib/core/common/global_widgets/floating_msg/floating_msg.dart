import 'package:flutter/material.dart';
import 'package:petzy_optimized/core/utils/constants/colors.dart';

class FloatingChatButton extends StatelessWidget {
  final VoidCallback onTap;
  final AssetImage image;
  final Color? backgroundColor;
  final Color? forgraoundColor;

  const FloatingChatButton({
    super.key,
    required this.onTap,
    this.image = const AssetImage('assets/icons/chat_icon.png'),
    this.backgroundColor,
    this.forgraoundColor,
  });

  @override
  Widget build(BuildContext context) {
    final buttonColor = backgroundColor ?? AppColors.surface(context);
    final iconColor = forgraoundColor ?? AppColors.textPrimary(context);

    return Container(
      decoration: BoxDecoration(color: buttonColor, shape: BoxShape.circle),
      child: FloatingActionButton(
        onPressed: onTap,
        backgroundColor: buttonColor,
        foregroundColor: iconColor,
        child: Image(image: image),
      ),
    );
  }
}
