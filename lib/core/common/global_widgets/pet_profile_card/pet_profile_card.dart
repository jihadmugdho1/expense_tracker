import 'package:flutter/material.dart';
import 'package:petzy_optimized/core/common/styles/global_text_style.dart';
import 'package:petzy_optimized/core/utils/constants/colors.dart';
import 'package:petzy_optimized/core/utils/constants/sizer.dart';

class PetProfileCard extends StatelessWidget {
  final String name;
  final String breed;
  final String details;
  final String imageUrl;
  final String age;
  final String gender;
  final double? height;
  final double? width;
  final VoidCallback? onTap;

  const PetProfileCard({
    super.key,
    required this.name,
    required this.breed,
    required this.details,
    required this.imageUrl,
    required this.age,
    required this.gender,
    this.height,
    this.width,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
      width: width ?? AppSizer.width * .6,
      height: height ?? AppSizer.height * .1,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.background(context),
        border: Border.all(color: AppColors.lightSurfaceVariant, width: 1),
        borderRadius: BorderRadius.circular(16),
       ),
      child: Row(
        children: [
          // Text section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTextStyle(
                    context,
                  ).boldTextStyle(fontSize: AppTextStyle.md),
                ),
                Text(
                  breed,
                  style: AppTextStyle().regularTextStyle(
                    fontSize: AppTextStyle.sm,
                    color: AppColors.accent,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      age,
                      style: AppTextStyle(context).regularTextStyle(
                        fontSize: 8,
                        color: AppColors.textSecondary(context),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      gender,
                      style: AppTextStyle(context).regularTextStyle(
                        fontSize: 8,
                        color: AppColors.textSecondary(context),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Avatar
          CircleAvatar(radius: 28, backgroundImage: NetworkImage(imageUrl)),
        ],
      ),
    ),   // Container
    );   // GestureDetector
  }
}
