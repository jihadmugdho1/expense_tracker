import 'package:flutter/material.dart';

class BlobPainter extends CustomPainter {
  BlobPainter({
    required this.blobPosition,
    required this.tabCount,
    required this.primaryColor,
  });

  final double blobPosition;
  final int tabCount;
  final Color primaryColor;

  @override
  void paint(Canvas canvas, Size size) {
    final tabWidth = size.width / tabCount;
    final cx = tabWidth * blobPosition + tabWidth / 2;
    final cy = size.height / 2;
    final bw = tabWidth * 0.95;
    final bh = size.height * 0.75;

    // Outer halo
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(cx, cy), width: bw * 1.18, height: bh * 1.18),
        const Radius.circular(30),
      ),
      Paint()
        ..color = primaryColor.withValues(alpha: 0.15)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12),
    );

    // Blob body
    final blobRect =
        Rect.fromCenter(center: Offset(cx, cy), width: bw, height: bh);
    canvas.drawRRect(
      RRect.fromRectAndRadius(blobRect, const Radius.circular(24)),
      Paint()
        ..shader = RadialGradient(
          center: const Alignment(0, -0.4),
          radius: 0.9,
          colors: [
            primaryColor.withValues(alpha: 0.28),
            primaryColor.withValues(alpha: 0.10),
            primaryColor.withValues(alpha: 0.03),
          ],
          stops: const [0.0, 0.6, 1.0],
        ).createShader(blobRect),
    );

    // Glass specular highlight
    final lensRect = Rect.fromLTWH(
      cx - bw * 0.28,
      cy - bh * 0.42,
      bw * 0.56,
      bh * 0.28,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(lensRect, const Radius.circular(12)),
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white.withValues(alpha: 0.55),
            Colors.white.withValues(alpha: 0.0),
          ],
        ).createShader(lensRect),
    );

    // Single drop bubble
    canvas.drawCircle(
      Offset(cx - bw * 0.20, cy - bh * 0.20),
      3.5,
      Paint()..color = Colors.white.withValues(alpha: 0.30),
    );

    // Glass rim highlight
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(10, 1.5, size.width - 20, 3),
        const Radius.circular(4),
      ),
      Paint()
        ..color = Colors.white.withValues(alpha: 0.50)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1.5),
    );
  }

  @override
  bool shouldRepaint(BlobPainter old) => old.blobPosition != blobPosition;
}
