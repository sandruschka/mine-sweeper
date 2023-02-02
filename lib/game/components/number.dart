import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:mine_sweeper/game/mine_sweeper_game.dart';

class Number extends Component {
  Number(int bombsAround) {
    if (bombsAround > sprites.length) return;
    sprite = sprites[bombsAround - 1];
  }

  late final Sprite? sprite;

  static final Sprite one =
      mineSweeperSprite(x: 14, y: 211, width: 17, height: 17);
  static final Sprite two =
      mineSweeperSprite(x: 31, y: 211, width: 17, height: 17);
  static final Sprite three =
      mineSweeperSprite(x: 48, y: 211, width: 17, height: 17);
  static final Sprite four =
      mineSweeperSprite(x: 65, y: 211, width: 17, height: 17);
  static final Sprite five =
      mineSweeperSprite(x: 82, y: 211, width: 17, height: 17);
  static final Sprite six =
      mineSweeperSprite(x: 99, y: 211, width: 17, height: 17);
  static final Sprite seven =
      mineSweeperSprite(x: 116, y: 211, width: 17, height: 17);
  static final Sprite eight =
      mineSweeperSprite(x: 133, y: 211, width: 17, height: 17);

  final List<Sprite> sprites = [one, two, three, four, five, six, seven, eight];

  @override
  void render(Canvas canvas) {
    sprite?.render(
      canvas,
      position: Vector2(0, 0),
      size: sprite?.srcSize.scaled(1.0),
    );
  }
}
