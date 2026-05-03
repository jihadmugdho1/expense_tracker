import 'package:flutter/material.dart';
import 'package:petzy_optimized/core/common/styles/global_text_style.dart';
import 'package:petzy_optimized/core/utils/constants/colors.dart';

class AddShortsCard extends StatelessWidget {
  final double width;
  final double height;
  final double scale; // optional manual scale
  final VoidCallback? onTap;

  const AddShortsCard({
    super.key,
    required this.width,
    required this.height,
    this.scale = 1,
    this.onTap, 
  });

  @override
  Widget build(BuildContext context) {
    final baseWidth = 160;
    final baseHeight = 220;

    final scaleW = width / baseWidth;
    final scaleH = height / baseHeight;

    final s = scale * (scaleW < scaleH ? scaleW : scaleH);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.primarylight, AppColors.primarydark],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20 * s),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 50 * s,
              height: 50 * s,
              decoration: BoxDecoration(
                color: AppColors.white.withValues(alpha: 0.3),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.add, size: 28 * s, color: AppColors.white),
            ),
            SizedBox(height: 12 * s),
            Text(
              "Add Shorts",
              style: AppTextStyle(
                context,
              ).semiBoldTextStyle(fontSize: 16 * s, color: AppColors.white),
            ),
          ],
        ),
      ),
    );
  }
}
