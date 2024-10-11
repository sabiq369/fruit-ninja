import 'dart:math';

import 'package:flame/components.dart';

class Utils {
  Utils._();

  static int getAngleOfTouchPoint({
    required Vector2 center,
    required double initAngle,
    required Vector2 touch,
  }) {
    final touchPoint = touch - center;
    double angle = atan2(touchPoint.y, touchPoint.x);
    angle -= initAngle;
    angle %= 2 * pi;
    return radiansToDegree(angle).toInt();
  }

  static double radiansToDegree(double angle) => angle * 180 / pi;
}
