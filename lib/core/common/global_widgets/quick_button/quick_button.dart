import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:petzy_optimized/core/common/styles/global_text_style.dart';
import 'package:petzy_optimized/core/utils/constants/colors.dart';
import 'package:petzy_optimized/core/utils/constants/sizer.dart';

class QuickButton extends StatelessWidget {
  final String image;
  final String title;
  final GestureTapCallback? ontap;
  final bool isSelected;

  const QuickButton({
    super.key,
    this.image = '',
    this.title = '',
    this.ontap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 2),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary.withValues(alpha: 0.1) : AppColors.lightSurfaceVariant,
                border: isSelected ? Border.all(color: AppColors.primary, width: 2) : null,
                borderRadius: BorderRadius.circular(12),
              ),
              child: SizedBox(
                width: 30.w,
                height: 30.h,
                child: SvgPicture.asset(image, fit: BoxFit.contain),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              maxLines: 1,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyle().getTextStyle(
                fontSize: AppTextStyle.sm,
                fontWeight: FontWeight.w500,
                color: isSelected ? AppColors.primary : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
