import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:petzy_optimized/core/common/global_widgets/post_card/post_like_bottom_sheet.dart';
import 'package:petzy_optimized/core/common/styles/global_text_style.dart';
import 'package:petzy_optimized/core/common/global_widgets/post_card/three_dot_dialog.dart';
import 'package:petzy_optimized/core/core.dart';
import 'package:petzy_optimized/core/utils/constants/colors.dart';
import 'package:petzy_optimized/core/utils/constants/icon_path.dart';

class PostCard extends StatelessWidget {
  final String userName;
  final String userAvatar;
  final String timeAgo;
  final String? location;
  final String? postText;
  final List<String> hashtags;
  final String? imageUrl;
  final String? caption;

  final int likes;
  final int comments;
  final int shares;
  final int save;

  final Widget? productWidget;

  final VoidCallback? onLike;
  final VoidCallback? onComment;
  final VoidCallback? onShare;
  final VoidCallback? onSave;
  final String? path;

  const PostCard({
    super.key,
    required this.userName,
    required this.userAvatar,
    required this.timeAgo,
    this.location,
    this.path,
    this.postText,
    this.hashtags = const [],
    this.imageUrl,
    this.productWidget,
    this.likes = 0,
    this.comments = 0,
    this.shares = 0,
    this.save = 0,
    this.onLike,
    this.onComment,
    this.onShare,
    this.onSave,
    this.caption,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background(context),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _header(context),


          if (caption != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Text(
                caption!,
                style: AppTextStyle(context).regularTextStyle(),
              ),
            ),
          if (postText != null || hashtags.isNotEmpty) _text(),
          if (imageUrl != null) ...[
            const SizedBox(height: 8),
            _image(context),
          ],

          if (productWidget != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: productWidget!,
            ),

          _counts(context),
          Divider(height: 1, color: AppColors.divider(context)),
          _actions(context),
        ],
      ),
    );
  }

  // 🔹 HEADER
  Widget _header(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: userAvatar.startsWith('http')
                ? NetworkImage(userAvatar)
                : AssetImage(userAvatar) as ImageProvider,
          ),
          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle(context).boldTextStyle(),
                ),
                if (location != null)
                  Text(
                    location!,
                    style: AppTextStyle(context).regularTextStyle(
                      fontSize: AppTextStyle.sm,
                      color: AppColors.textSecondary(context),
                    ),
                  ),
                Text(
                  timeAgo,
                  style: AppTextStyle(context).regularTextStyle(
                    fontSize: 11,
                    color: AppColors.textSecondary(context),
                  ),
                ),
              ],
            ),
          ),

          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) {
                  return PostOptionsDialog(
                    onAddSection: () {
                      Navigator.pop(context);
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  // 🔹 TEXT
  Widget _text() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (postText != null) Text(postText!),
          if (hashtags.isNotEmpty) const SizedBox(height: 6),
          if (hashtags.isNotEmpty)
            Wrap(
              spacing: 6,
              children: hashtags
                  .map(
                    (e) => Text(
                  e,
                  style: AppTextStyle().regularTextStyle(
                    color: AppColors.accent,
                  ),
                ),
              )
                  .toList(),
            ),

          const SizedBox(height: 10),
        ],
      ),
    );
  }

  // 🔹 IMAGE
  Widget _image(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
      ),
      child: Image.network(
        imageUrl!,
        width: double.infinity,
        height: .34 * MediaQuery.of(context).size.height,
        fit: BoxFit.cover,
      ),
    );
  }

  // 🔹 COUNTS
  Widget _counts(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
      

GestureDetector(
  onTap: () {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => LikesBottomSheet(likes: likes),
    );
  },
  child: Text(
    "$likes likes",
    style: AppTextStyle().regularTextStyle(
      fontSize: AppTextStyle.sm,
    ),
  ),
),
          Text(
            "$comments comments • $shares shares",
            style: AppTextStyle().regularTextStyle(
              fontSize: AppTextStyle.sm,
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 ACTIONS
  Widget _actions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _action(context, IconPath.postLike, likes, onLike),
          _action(context, IconPath.postComment, comments, onComment),
          _action(context, IconPath.postShare, shares, onShare),
          Spacer(),
          _action(context, IconPath.postSave, save, onSave),
        ],
      ),
    );
  }

  Widget _action(
      BuildContext context,
      String svgPath,
      int count,
      VoidCallback? onTap,
      ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Row(
          children: [
              SvgPicture.asset(
                svgPath,
                width: 18,
                height: 18,
                color: AppColors.textPrimary(context),
              ),
  
            const SizedBox(width: 6),

            if (count > 0)
              Text(
                count.toString(),
                style: AppTextStyle(context).regularTextStyle(
                  color: AppColors.textPrimary(context),
                ),
              ),
          ],
        ),
      ),
    );
  }
}