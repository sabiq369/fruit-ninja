import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:fruit_ninja/src/components/back_button.dart';
import 'package:fruit_ninja/src/components/fruit_component.dart';
import 'package:fruit_ninja/src/components/pause_button.dart';
import 'package:fruit_ninja/src/components/rectangle_test.dart';
import 'package:fruit_ninja/src/config/app_config.dart';
import 'package:fruit_ninja/src/game.dart';

class GamePage extends Component with DragCallbacks, HasGameRef<MyGame> {
  final Random random = Random();
  late List<double> fruitsTime;
  late double time, countDown;
  TextComponent? _countDownTextComponent;
  bool _countDownFinished = false;

  @override
  void onMount() {
    super.onMount();
    fruitsTime = [];

    countDown = 3;
    time = 0;
    _countDownFinished = false;
    double initTime = 0;
    for (int i = 0; i < 40; i++) {
      if (i != 0) {
        initTime = fruitsTime.last;
      }
      final millisecondTime = random.nextInt(100) / 100;
      final componentTime = random.nextInt(1) + millisecondTime + initTime;
      fruitsTime.add(componentTime);
    }
    addAll(
      [
        BackButton(
          onPressed: () {
            removeAll(children);
            game.router.pop();
          },
        ),
        PauseButton(),
        _countDownTextComponent = TextComponent(
            text: '${countDown.toInt() + 1}',
            position: game.size / 2,
            anchor: Anchor.center,
            size: Vector2.all(50)),
      ],
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (!_countDownFinished) {
      countDown -= dt;
      _countDownTextComponent?.text = (countDown.toInt() + 1).toString();
      if (countDown < 0) {
        _countDownFinished = true;
      }
    } else {
      _countDownTextComponent?.removeFromParent();
      time += dt;
      fruitsTime
          .where(
            (element) => element < time,
          )
          .toList()
          .forEach(
        (element) {
          final gameSize = game.size;
          double posX = random.nextInt(gameSize.x.toInt()).toDouble();
          Vector2 fruitPosition = Vector2(posX, gameSize.y);
          Vector2 velocity = Vector2(0, game.maxVerticalVelocity);
          final randFruit = game.fruits.random();
          add(FruitComponent(this, fruitPosition,
              acceleration: AppConfig.acceleration,
              fruit: randFruit,
              size: AppConfig.shapeSize,
              image: game.images.fromCache(randFruit.image),
              pageSize: gameSize,
              velocity: velocity));
          fruitsTime.remove(element);
        },
      );
    }
  }

  @override
  bool containsLocalPoint(Vector2 point) => true;

  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);
    componentsAtPoint(event.canvasStartPosition).forEach(
      (element) {
        if (element is FruitComponent) {
          element.touchAtPoint(event.canvasStartPosition);
        }
      },
    );
  }
}
