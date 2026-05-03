import 'package:flutter/material.dart';
import 'package:petzy_optimized/core/common/styles/global_text_style.dart';
import 'package:petzy_optimized/core/utils/constants/colors.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final String location;
  final double rating;
  final int reviews;
  final double price;
  final double oldPrice;
  final String image;
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.title,
    required this.location,
    required this.rating,
    required this.reviews,
    required this.price,
    required this.oldPrice,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        width: .7 * MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.background(context),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border(context)),
        ),
        child: Row(
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                image,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(width: 10),

            // Details
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(title, style: AppTextStyle(context).getTextStyle(fontSize: 8)),

                  const SizedBox(height: 2),

                  // Location
                  Row(
                    children: [
                      Icon(
                        Icons.circle,
                        size: 6,
                        color: AppColors.textSecondary(context),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        location,
                        style: AppTextStyle(context).regularTextStyle(
                          fontSize: AppTextStyle.sm,
                          color: AppColors.textSecondary(context),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  // Rating + Price
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        size: 14,
                        color: AppColors.warning,
                      ),
                      const SizedBox(width: 4),

                      Text(
                        "$rating ($reviews)",
                        style: AppTextStyle().regularTextStyle(
                          fontSize: AppTextStyle.sm,
                        ),
                      ),

                      const SizedBox(width: 8),

                      Text(
                        "\$$price",
                        style: AppTextStyle().regularTextStyle(
                          fontSize: AppTextStyle.sm,
                        ),
                      ),

                      const SizedBox(width: 6),

                      Text(
                        "\$$oldPrice",
                        style: AppTextStyle().regularTextStyle(
                          fontSize: AppTextStyle.sm,
                          color: AppColors.error,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
