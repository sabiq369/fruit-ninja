import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:fruit_ninja/src/config/app_config.dart';
import 'package:fruit_ninja/src/models/fruit_model.dart';
import 'package:fruit_ninja/src/routes/game_over.dart';
import 'package:fruit_ninja/src/routes/game_page.dart';
import 'package:fruit_ninja/src/routes/home_page.dart';
import 'package:fruit_ninja/src/routes/pause_game.dart';

class MyGame extends FlameGame {
  late final RouterComponent router;
  late double maxVerticalVelocity;
  final List<FruitModel> fruits = [
    FruitModel(image: "bomb.png", isBomb: true),
    FruitModel(image: "apple.png"),
    FruitModel(image: 'grapes.png'),
    FruitModel(image: "kiwi.png"),
    FruitModel(image: "orange.png"),
    FruitModel(image: "pineapple.png"),
  ];

  @override
  void onLoad() async {
    super.onLoad();
    for (final fruit in fruits) {
      await images.load(fruit.image);
    }
    addAll([
      ParallaxComponent(
        parallax: Parallax(
          [
            await ParallaxLayer.load(
              ParallaxImageData(
                'bg_3.png',
              ),
            )
          ],
        ),
      ),
      router = RouterComponent(
        initialRoute: 'home',
        routes: {
          'home': Route(HomePage.new),
          'game-page': Route(GamePage.new),
          'pause': PauseRout(),
          'game-over': GameOverRoute(),
        },
      )
    ]);
    // add(RectangleTest(size / 2, pageSize: size, velocity: Vector2(0, 60)));
  }

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
