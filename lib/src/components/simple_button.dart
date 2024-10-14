import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';

abstract class SimpleButton extends PositionComponent with TapCallbacks {
  final Paint _borderPaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = Color(0x66ffffff);
  final Paint _iconPaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = Color(0x66aaaaaa)
    ..strokeWidth = 7;
  final Path _iconPath;
  VoidCallback? action;
  SimpleButton(
    this._iconPath, {
    super.position,
    this.action,
  }) : super(size: Vector2.all(40));

  @override
  void render(Canvas canvas) {
    canvas.drawRRect(RRect.fromRectAndRadius(size.toRect(), Radius.circular(8)),
        _borderPaint);
    canvas.drawPath(_iconPath, _iconPaint);
  }

  @override
  void onTapDown(TapDownEvent event) {
    _iconPaint.color = const Color(0xffffffff);
  }

  @override
  void onTapUp(TapUpEvent event) {
    _iconPaint.color = const Color(0xffaaaaaa);
    action?.call();
  }
}
