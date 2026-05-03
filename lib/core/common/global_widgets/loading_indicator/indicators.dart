import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Indicators {
  Indicators._();

  static Widget twistingDots({required Color color, required double size}) {
    return LoadingAnimationWidget.twistingDots(
      leftDotColor: color,
      rightDotColor: color,
      size: size,
    );
  }

  static Widget waveDots({required Color color, required double size}) {
    return LoadingAnimationWidget.waveDots(color: color, size: size);
  }

  static Widget horizontalRotatingDots({
    required Color color,
    required double size,
  }) {
    return LoadingAnimationWidget.horizontalRotatingDots(
      color: color,
      size: size,
    );
  }
}
