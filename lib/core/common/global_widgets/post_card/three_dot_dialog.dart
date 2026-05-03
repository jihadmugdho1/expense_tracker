import 'package:flutter/material.dart';
import 'package:petzy_optimized/core/common/styles/global_text_style.dart';
import 'package:petzy_optimized/core/utils/constants/colors.dart';

class PostOptionsDialog extends StatelessWidget {
  final VoidCallback onAddSection;

  const PostOptionsDialog({super.key, required this.onAddSection});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.surface(context),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),

          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text("Edit Post"),
            onTap: () {
              Navigator.pop(context);
              // edit logic
            },
          ),

          ListTile(
            leading: const Icon(Icons.delete, color: AppColors.error),
            title: Text(
              "Delete Post",
              style: AppTextStyle().regularTextStyle(
                color: AppColors.error,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              // delete logic
            },
          ),

          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
