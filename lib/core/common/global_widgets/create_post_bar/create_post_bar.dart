import 'package:flutter/material.dart';
import 'package:petzy_optimized/core/utils/constants/colors.dart';

class CreatePostBar extends StatelessWidget {
  final String? avatarUrl;
  final String hintText;
  final VoidCallback? onPhotoTap;
  final VoidCallback? onTap;
  final Color? fillColor;
  final Color? photoIconColor;

  const CreatePostBar({
    super.key,
    this.avatarUrl,
    this.hintText = "What's on your mind?",
    this.onPhotoTap,
    this.onTap,
    this.fillColor,
    this.photoIconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: avatarUrl != null
                ? NetworkImage(avatarUrl!)
                : null,
            backgroundColor: AppColors.primary.withValues(alpha: 0.2),
            child: avatarUrl == null
                ? const Icon(Icons.person, color: Colors.white, size: 20)
                : null,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: GestureDetector(
              onTap: onTap,
              child: TextField(
                enabled: onTap == null,
                onTap: onTap,
                decoration: InputDecoration(
                  hintText: hintText,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: fillColor ?? Colors.grey[200],
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: Icon(
              Icons.photo_library,
              color: photoIconColor ?? Colors.green,
            ),
            onPressed: onPhotoTap,
          ),
        ],
      ),
    );
  }
}
