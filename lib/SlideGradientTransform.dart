import 'package:flutter/cupertino.dart';

class SlideGradientTransform extends GradientTransform{
  final double percent;

  SlideGradientTransform({required this.percent});
  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * percent, 0, 0);
  }
}