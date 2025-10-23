import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class CircularRevealPainter extends CustomPainter {
  CircularRevealPainter({
    required this.image,
    required this.center,
    required this.progress,
    required this.isReverse,
  });

  final ui.Image image;
  final Offset center;
  final double progress;
  final bool isReverse;

  @override
  void paint(Canvas canvas, Size size) {
    final double maxRadius = _calculateMaxRadius(center, size);
    final double currentRadius = isReverse ? maxRadius * (1.0 - progress) : maxRadius * progress;

    double opacity = 1.0;
    if (isReverse && progress > 0.85) {
      opacity = 1.0 - ((progress - 0.85) / 0.15);
    }

    final Paint layerPaint = Paint()..color = Color.fromRGBO(255, 255, 255, opacity);
    canvas.saveLayer(Rect.fromLTWH(0, 0, size.width, size.height), layerPaint);

    final Rect imageRect = Rect.fromLTWH(0, 0, size.width, size.height);
    paintImage(canvas: canvas, rect: imageRect, image: image, fit: BoxFit.cover);

    final Paint clearPaint = Paint()
      ..blendMode = BlendMode.dstOut
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, currentRadius, clearPaint);

    canvas.restore();
  }

  double _calculateMaxRadius(Offset center, Size size) {
    final double topLeft = center.distance;
    final double topRight = (center - Offset(size.width, 0)).distance;
    final double bottomLeft = (center - Offset(0, size.height)).distance;
    final double bottomRight = (center - Offset(size.width, size.height)).distance;

    return [topLeft, topRight, bottomLeft, bottomRight].reduce((double a, double b) => a > b ? a : b);
  }

  @override
  bool shouldRepaint(CircularRevealPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

