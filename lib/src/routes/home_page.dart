import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:fruit_ninja/src/components/rounded_button.dart';
import 'package:fruit_ninja/src/game.dart';

class HomePage extends Component with HasGameRef<MyGame> {
  late final RoundedButton _button1;

  @override
  void onLoad() async {
    super.onLoad();
    add(_button1 = RoundedButton(
        text: 'Start',
        onPressed: () {
          game.router.pushNamed('game-page');
        },
        color: Colors.blue,
        borderColor: Colors.white));
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    _button1.position = size / 2;
  }
}
