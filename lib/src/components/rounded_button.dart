import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/widgets.dart';

class RoundedButton extends PositionComponent with TapCallbacks {
  final String text;
  final VoidCallback onPressed;
  final TextPaint _textDrawable;
  late final Offset _textOffset;
  late final RRect _rRect;
  late final Paint _borderPaint;

  RoundedButton({
    required this.text,
    required this.onPressed,
    required Color color,
    required Color borderColor,
  }) : _textDrawable = TextPaint(
            style: TextStyle(
          fontSize: 20,
          color: Color(0xff000000),
          fontWeight: FontWeight.w800,
        )).toTextPainter(text) {}
}
