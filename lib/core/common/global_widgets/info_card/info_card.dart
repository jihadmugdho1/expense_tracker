import 'package:flutter/material.dart';
import 'package:petzy_optimized/core/common/global_widgets/common_button/small_button/small_button.dart';
import 'package:petzy_optimized/core/common/styles/global_text_style.dart';
import 'package:petzy_optimized/core/utils/constants/colors.dart';

class InfoCard extends StatelessWidget {
  final IconData icon;
  final Color iconBgColor;
  final Color? backgroundColor;

  final String title;
  final String subtitle;
  final String? description;

  final Widget? trailing; // 👈 THIS IS THE KEY
  final VoidCallback? onTap;

  const InfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.description,
    this.backgroundColor = AppColors.white,
    this.iconBgColor = AppColors.primarylight,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cardColor = backgroundColor ?? AppColors.surface(context);
    final subtitleColor = AppColors.textSecondary(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border(context)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// Icon
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 20),
            ),

            const SizedBox(width: 12),

            /// Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Title Row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: AppTextStyle(context).semiBoldTextStyle(
                            fontSize: AppTextStyle.md,
                            color: AppColors.textPrimary(context),
                          ),
                        ),
                      ),              
                    ],
                  ),

                  const SizedBox(height: 4),

                  /// Subtitle
                  Text(
                    subtitle,
                    style: AppTextStyle(context).regularTextStyle(
                      color: subtitleColor,
                      fontSize: AppTextStyle.sm,
                    ),
                  ),

                  /// Description
                  if (description != null) ...[
                    const SizedBox(height: 6),
                    Text(
                      description!,
                      style: AppTextStyle(context).regularTextStyle(
                        color: subtitleColor,
                        fontSize: AppTextStyle.sm,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            IconTextButton(text: 'View', onTap: onTap,),
            
          ],
        ),
      ),
    );
  }
}
