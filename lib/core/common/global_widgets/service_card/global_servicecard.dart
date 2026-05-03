import 'package:flutter/material.dart';
import 'package:petzy_optimized/core/common/styles/global_text_style.dart';
import 'package:petzy_optimized/core/utils/constants/colors.dart';
import 'package:petzy_optimized/core/utils/constants/sizer.dart';

class ServiceCard extends StatelessWidget {
  final String? imageUrl;
  final double? rating;
  final String? title;
  final String? productAmount;
  final String? location;
  final double? price;
  final VoidCallback? onTap;
  final VoidCallback? onFavorite;
  final int? beds;
  final int? baths;
  final int? pets;

  const ServiceCard({
    super.key,
    required this.imageUrl,
    required this.rating,
    required this.title,
    this.productAmount,
    required this.location,
    required this.price,
    required this.onTap,
    this.onFavorite,
    this.beds,
    this.baths,
    this.pets,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: .45 * AppSizer.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Image + Overlay
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      imageUrl ?? '',
                      width: .45 * AppSizer.width,
                      height: .40 * AppSizer.width,
                      fit: BoxFit.cover,
                    ),
                  ),

                  /// Rating
                  Positioned(
                    top: 8.h,
                    left: 8.h,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white.withValues(alpha: 0.2),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: AppColors.warning,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            rating.toString(),
                            style: AppTextStyle().regularTextStyle(
                              fontSize: AppTextStyle.sm,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// Favorite Button
                  Positioned(
                    top: 8.h,
                    right: 8.h,
                    child: GestureDetector(
                      onTap: onFavorite,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: AppColors.white.withValues(alpha: 0.2),
                        ),
                        child: const Icon(Icons.favorite_border, size: 16),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),
              if (beds != null || baths != null || pets != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    children: [
                      if (beds != null) ...[
                        Icon(
                          Icons.bed_outlined,
                          size: 14,
                          color: AppColors.textSecondary(context),
                        ),
                        const SizedBox(width: 2),
                        Text(
                          '$beds',
                          style: AppTextStyle(
                            context,
                          ).regularTextStyle(fontSize: AppTextStyle.sm),
                        ),
                        const SizedBox(width: 8),
                      ],
                      if (baths != null) ...[
                        Icon(
                          Icons.shower_outlined,
                          size: 14,
                          color: AppColors.textSecondary(context),
                        ),
                        const SizedBox(width: 2),
                        Text(
                          '$baths',
                          style: AppTextStyle(
                            context,
                          ).regularTextStyle(fontSize: AppTextStyle.sm),
                        ),
                        const SizedBox(width: 8),
                      ],
                      if (pets != null) ...[
                        Icon(
                          Icons.pets,
                          size: 14,
                          color: AppColors.textSecondary(context),
                        ),
                        const SizedBox(width: 2),
                        Text(
                          '$pets',
                          style: AppTextStyle(
                            context,
                          ).regularTextStyle(fontSize: AppTextStyle.sm),
                        ),
                      ],
                    ],
                  ),
                ),
              Text(
                title ?? '',
                style: AppTextStyle(
                  context,
                ).boldTextStyle(fontSize: AppTextStyle.md),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              /// Location
              Text(
                location ?? '',
                style: AppTextStyle(context).getTextStyle(
                  fontSize: AppTextStyle.sm,
                  color: AppColors.textSecondary(context),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 4),

              /// Price
              Row(
                children: [
                  Text(
                    "\$${price?.toStringAsFixed(0) ?? '0'}",
                    style: AppTextStyle(
                      context,
                    ).getTextStyle(fontSize: 10, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(width: 4),
                  if (productAmount != null && productAmount!.isNotEmpty) ...[
                    const SizedBox(width: 4),
                    Text(
                      productAmount!,
                      style: AppTextStyle(context).regularTextStyle(
                        fontSize: AppTextStyle.sm,
                        color: AppColors.textSecondary(context),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
