import 'package:flutter/material.dart';
import 'package:petzy_optimized/core/common/styles/global_text_style.dart';
import 'package:petzy_optimized/core/utils/constants/colors.dart';
import 'package:petzy_optimized/core/utils/constants/sizer.dart';

class SpecialCard extends StatelessWidget {
  final String? imageUrl;
  final String? title;
  final String? subtitle;
  final String? description;
  final VoidCallback? onTap;

  const SpecialCard({
    super.key,
    this.imageUrl,
    this.onTap,
    this.title,
    this.subtitle,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 180.h,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(18)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Stack(
          children: [
            /// 🔹 Background Image
            Positioned.fill(child: Image.network(imageUrl!, fit: BoxFit.cover)),

            /// 🔹 Gradient Overlay
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.black.withValues(alpha: 60),
                      Colors.transparent,
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ),
            ),

            /// 🔹 Text Content
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// Discount
                    Text(
                      title ?? "30%",
                      style: AppTextStyle().getTextStyle(
                        fontSize: AppTextStyle.heading,
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    /// Title
                    SizedBox(
                      width: AppSizer.width * 0.6,
                      child: Text(
                        subtitle ?? "Exclusive Offer",
                        style: const TextStyle(fontSize: 16, color: AppColors.white),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 4),
                    /// Description
                    SizedBox(
                      width: AppSizer.width * 0.6,
                      child: Text(
                        description ?? "Up to 30% off on selected pet service today.",
                        style: const TextStyle(fontSize: 11, color: AppColors.lightBorder),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
