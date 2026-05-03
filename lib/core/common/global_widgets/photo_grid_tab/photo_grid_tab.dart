import 'package:flutter/material.dart';
import 'package:petzy_optimized/core/utils/constants/colors.dart';

class PhotoItem {
  final String imageUrl;
  final bool isVideo;
  const PhotoItem({required this.imageUrl, this.isVideo = false});
}

class PhotoGridTab extends StatelessWidget {
  final String title;
  final List<PhotoItem> photos;

  const PhotoGridTab({
    super.key,
    this.title = 'My Photos',
    required this.photos,
  });

  static const defaultPhotos = <PhotoItem>[
    PhotoItem(imageUrl: 'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e'),
    PhotoItem(imageUrl: 'https://images.unsplash.com/photo-1552053831-71594a27632d', isVideo: true),
    PhotoItem(imageUrl: 'https://images.unsplash.com/photo-1543466835-00a7907e9de1'),
    PhotoItem(imageUrl: 'https://images.unsplash.com/photo-1517423440428-a5a00ad493e8', isVideo: true),
    PhotoItem(imageUrl: 'https://images.unsplash.com/photo-1605568427561-40dd23c2acea'),
    PhotoItem(imageUrl: 'https://images.unsplash.com/photo-1543852786-1cf6624b9987'),
    PhotoItem(imageUrl: 'https://images.unsplash.com/photo-1587300003388-59208cc962cb'),
    PhotoItem(imageUrl: 'https://images.unsplash.com/photo-1525253086316-d0c936c814f8'),
    PhotoItem(imageUrl: 'https://images.unsplash.com/photo-1518717758536-85ae29035b6d', isVideo: true),
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
            child: Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          sliver: SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _PhotoCell(item: photos[index]),
              childCount: photos.length,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 6,
              mainAxisSpacing: 6,
              childAspectRatio: 1,
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 20)),
      ],
    );
  }
}

class _PhotoCell extends StatelessWidget {
  final PhotoItem item;
  const _PhotoCell({required this.item});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            color: AppColors.primary.withValues(alpha: 0.06),
            child: Image.network(
              item.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Container(
                color: AppColors.primary.withValues(alpha: 0.1),
              ),
            ),
          ),
          if (item.isVideo)
            Positioned(
              top: 6,
              right: 6,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.45),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(Icons.videocam_outlined, size: 14, color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}
