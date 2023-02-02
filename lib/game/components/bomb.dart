import 'dart:ui';

import 'package:flame/components.dart';
import 'package:mine_sweeper/game/mine_sweeper_game.dart';

class Bomb extends Component {
  Sprite sprite = redBomb;

  hit() => sprite = redBomb;

  reveal() => sprite = whiteBomb;

  static final Sprite whiteBomb =
      mineSweeperSprite(x: 99, y: 194, width: 17, height: 17);
  static final Sprite redBomb =
      mineSweeperSprite(x: 116, y: 194, width: 17, height: 17);
  static final Sprite bombWithCross =
      mineSweeperSprite(x: 133, y: 194, width: 17, height: 17);

  @override
  void render(Canvas canvas) {
    sprite.render(
      canvas,
      position: Vector2(0, 0),
      size: sprite.srcSize.scaled(1.0),
    );
  }
}
