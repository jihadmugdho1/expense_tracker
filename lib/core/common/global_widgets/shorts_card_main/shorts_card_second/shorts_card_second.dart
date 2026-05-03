import 'package:flutter/material.dart';
import 'package:petzy_optimized/core/common/styles/global_text_style.dart';
import 'package:petzy_optimized/core/utils/constants/colors.dart';

class ShortsCard extends StatelessWidget {
  final double width;
  final double height;
  final double scale;
  final String? image;

  final String title;
  final int likes;
  final int comments;
  final int views;

  final VoidCallback? onTap;

  const ShortsCard({
    super.key,
    required this.width,
    required this.height,
    this.scale = 1,
    required this.title,
    this.image,
    this.likes = 0,
    this.comments = 0,
    this.views = 0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final baseWidth = .33 * MediaQuery.of(context).size.width;
    final baseHeight = .33 * MediaQuery.of(context).size.height;

    final scaleW = width / baseWidth;
    final scaleH = height / baseHeight;

    final s = scale * (scaleW < scaleH ? scaleW : scaleH);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: 0.1),
                blurRadius: 6 * s,
                offset: Offset(0, 4 * s),
              ),
            ],
            color: AppColors.surfaceVariant(context),
            borderRadius: BorderRadius.circular(20 * s),
          ),
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Center(
                      child: Image.network(
                        image?? "https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=500&q=60",
                        width: width,
                        height: height,
                        fit: BoxFit.cover,
                      ),
                    ),

                    // Play button
                    Positioned(
                      top: 8 * s,
                      right: 8 * s,
                      child: Container(
                        padding: EdgeInsets.all(6 * s),
                        decoration: BoxDecoration(
                          color: AppColors.black.withValues(alpha: 0.26),
                          borderRadius: BorderRadius.circular(10 * s),
                        ),
                        child: Icon(
                          Icons.play_arrow,
                          size: 18 * s,
                          color: AppColors.white,
                        ),
                      ),
                    ),

                    // Title
                    Positioned(
                      top: 8 * s,
                      left: 8 * s,
                      right: 40 * s,
                      child: Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle(context).mediumTextStyle(
                          fontSize: 14 * s,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Bottom stats
              Container(
                padding: EdgeInsets.symmetric(vertical: 6 * s),
                decoration: BoxDecoration(
                  color: AppColors.background(context),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20 * s),
                    bottomRight: Radius.circular(20 * s),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _iconText(context, Icons.favorite_border, likes, s),
                    _iconText(context, Icons.chat_bubble_outline, comments, s),
                    _iconText(context, Icons.remove_red_eye_outlined, views, s),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _iconText(BuildContext context, IconData icon, int value, double s) {
    return Row(
      children: [
        Icon(icon, size: 16 * s, color: AppColors.textSecondary(context)),
        SizedBox(width: 4 * s),
        Text(
          value.toString(),
          style: AppTextStyle(context).regularTextStyle(fontSize: 12 * s),
        ),
      ],
    );
  }
}
