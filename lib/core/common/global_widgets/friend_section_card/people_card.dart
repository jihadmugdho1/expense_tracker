import 'package:flutter/material.dart';
import 'package:petzy_optimized/core/common/styles/global_text_style.dart';
import 'package:petzy_optimized/core/utils/constants/colors.dart';
import 'package:petzy_optimized/core/utils/constants/enums.dart';


class FriendCard extends StatelessWidget {
  final String name;
  final String subtitle;
  final String imageUrl;
  final FriendCardType type;

  final VoidCallback onCardTap;
  final VoidCallback? onPrimaryTap;
  final VoidCallback? onSecondaryTap;

  const FriendCard({
    super.key,
    required this.name,
    required this.subtitle,
    required this.imageUrl,
    required this.type,
    required this.onCardTap,
    this.onPrimaryTap,
    this.onSecondaryTap,
  });

  @override
  Widget build(BuildContext context) {
    String primaryText = '';
    String secondaryText = '';
    bool isPrimaryDisabled = false;

    switch (type) {
      case FriendCardType.friend:
        primaryText = "Message";
        secondaryText = "Unfriend";
        break;
      case FriendCardType.request:
        primaryText = "Accept";
        secondaryText = "Reject";
        break;
      case FriendCardType.sentRequest:
        primaryText = "Requested";
        secondaryText = "Cancel";
        isPrimaryDisabled = true;
        break;
    }

    return InkWell(
      onTap: onCardTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.background(context),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.textSecondary(context).withValues(alpha: 0.2),
              blurRadius: 4,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(radius: 28, backgroundImage: NetworkImage(imageUrl)),
            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: AppTextStyle(
                      context,
                    ).boldTextStyle(fontSize: AppTextStyle.lg),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: AppTextStyle(context).regularTextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary(context),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
            TextButton(
              onPressed: isPrimaryDisabled ? null : onPrimaryTap,
              child: Text(primaryText),
            ),
            const SizedBox(width: 8),
            TextButton(onPressed: onSecondaryTap, child: Text(secondaryText)),
          ],
        ),
      ),
    );
  }
}
