import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:mine_sweeper/game/mine_sweeper_game.dart';

class Flag extends Component with TapCallbacks {
  static final Sprite flag =
      mineSweeperSprite(x: 48, y: 194, width: 17, height: 17);

  @override
  void onLongTapDown(TapDownEvent event) {
    removeFromParent();
    super.onLongTapDown(event);
  }

  @override
  void render(Canvas canvas) {
    flag.render(
      canvas,
      position: Vector2(0, 0),
      size: flag.srcSize.scaled(1.0),
    );
  }
}
