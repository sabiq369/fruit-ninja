import 'dart:ui';

import 'package:flame/components.dart';
import 'package:fruit_ninja/src/components/simple_button.dart';
import 'package:fruit_ninja/src/game.dart';

class BackButton extends SimpleButton with HasGameRef<MyGame> {
  BackButton({VoidCallback? onPressed})
      : super(
          Path()
            ..moveTo(22, 8)
            ..lineTo(10, 20)
            ..lineTo(22, 32)
            ..moveTo(12, 20)
            ..lineTo(34, 20),
          position: Vector2.all(10),
        ) {
    super.action = onPressed ?? () => game.router.pop();
  }
}
