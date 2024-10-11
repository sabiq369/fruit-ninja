import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:fruit_ninja/src/components/rectangle_test.dart';
import 'package:fruit_ninja/src/config/app_config.dart';
import 'package:flame/components.dart';

class MyGame extends FlameGame {
  late final RouterComponent router;
  late double maxVerticalVelocity;

  @override
  void onLoad() async {
    super.onLoad();
    addAll([
      ParallaxComponent(
        parallax: Parallax(
          [
            await ParallaxLayer.load(
              ParallaxImageData(
                'bg.png',
              ),
            )
          ],
        ),
      ),
      router = RouterComponent(initialRoute: 'home', routes: {})
    ]);
    add(RectangleTest(size / 2, pageSize: size, velocity: Vector2(0, 60)));
  }

  // @override
  // void onDragUpdate(DragUpdateEvent event) {
  //   super.onDragUpdate(event);
  //   componentsAtPoint(event.canvasStartPosition).forEach(
  //     (element) {
  //       if (element is RectangleTest) {
  //         element.touchAtPoint(event.canvasStartPosition);
  //       }
  //     },
  //   );
  // }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    getMaxVerticalVelocity(size);
  }

  void getMaxVerticalVelocity(Vector2 size) {
    maxVerticalVelocity = sqrt(2 *
        (AppConfig.gravity.abs() + AppConfig.acceleration.abs()) *
        (size.y - AppConfig.objSize * 2));
  }
}
