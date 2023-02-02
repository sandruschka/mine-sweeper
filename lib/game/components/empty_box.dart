import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flutter/painting.dart';
import 'package:mine_sweeper/game/mine_sweeper_game.dart';

class EmptyBox extends Component with TapCallbacks {
  Sprite sprite = unClickedSquare;

  clicked() => sprite = clickedEmptySquare;

  reveal() => sprite = clickedEmptySquare;

  static final Sprite unClickedSquare =
      mineSweeperSprite(x: 14, y: 194, width: 17, height: 17);

  static final Sprite clickedEmptySquare =
      mineSweeperSprite(x: 31, y: 194, width: 17, height: 17);

  @override
  void onTapDown(TapDownEvent event) {
    removeFromParent();
    super.onTapDown(event);
  }

  @override
  void render(Canvas canvas) {
    sprite.render(
      canvas,
      position: Vector2(0, 0),
      size: sprite.srcSize.scaled(1.0),
    );
  }
}
