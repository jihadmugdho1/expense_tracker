import 'package:flutter/material.dart';
import 'package:petzy_optimized/core/utils/constants/colors.dart';
import 'package:petzy_optimized/core/common/styles/global_text_style.dart';

class UnderlineTabBar extends StatelessWidget {
  final List<String> tabs;
  final List<Widget>? images;

  const UnderlineTabBar({
    super.key,
    required this.tabs,
    this.images,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      isScrollable: true,
      tabAlignment: TabAlignment.start,
      padding: EdgeInsets.zero,
      indicatorPadding: EdgeInsets.zero,

      indicatorSize: TabBarIndicatorSize.label,
      indicator: const UnderlineTabIndicator(
        borderSide: BorderSide(
          color: AppColors.primary,
          width: 2,
        ),
      ),

      labelColor: AppColors.primary,
      unselectedLabelColor: AppColors.textSecondary(context),

      labelStyle: AppTextStyle(context).semiBoldTextStyle(
        fontSize: 14,
      ),
      unselectedLabelStyle: AppTextStyle(context).regularTextStyle(
        fontSize: 14,
      ),

      tabs: List.generate(
        tabs.length,
        (index) => Tab(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (images != null && index < images!.length) ...[
                images![index],
                const SizedBox(width: 6),
              ],
              Text(tabs[index]),
            ],
          ),
        ),
      ),
    );
  }
}