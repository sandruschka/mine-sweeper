import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:mine_sweeper/game/bloc/game_bloc.dart';
import 'package:mine_sweeper/game/components/components.dart';
import 'package:mine_sweeper/game/mine_sweeper_game.dart';

class BoardSquareController extends PositionComponent
    with
        TapCallbacks,
        HasGameRef<MineSweeperGame>,
        FlameBlocListenable<GameBloc, GameBlocState> {
  BoardSquareController({
    this.hasBomb = false,
    this.bombsAround = 0,
    required this.placementInGrid,
    super.position,
  }) : super(size: boxSize);

  final Vector2 placementInGrid;
  bool hasFlag = false;
  bool isRevealed = false;
  bool isLongTap = false;

  @override
  void onNewState(GameBlocState state) {
    if (state.isBombHit == true && !isRevealed) {
      if (hasBomb) {
        add(Bomb()..reveal());
      } else if (bombsAround == 0) {
        add(EmptyBox()..reveal());
      } else {
        add(Number(bombsAround));
      }
    } else if (!isRevealed &&
        _isRevealedSquareNextToThisSquare(state.placementInGrid) &&
        !hasBomb) {
      isRevealed = true;
      if (bombsAround == 0) {
        add(EmptyBox()..clicked());
        gameRef.gameBloc.add(OnRevealSurroundingSquares(placementInGrid));
      } else {
        gameRef.gameBloc.add(OnRevealSquare());
        add(Number(bombsAround));
      }
    }

    super.onNewState(state);
  }

  bool _isRevealedSquareNextToThisSquare(Vector2? p) {
    if (p == null) return false;
    if (p.x + 1 == placementInGrid.x && p.y == placementInGrid.y ||
        p.x - 1 == placementInGrid.x && p.y == placementInGrid.y ||
        p.y + 1 == placementInGrid.y && p.x == placementInGrid.x ||
        p.y - 1 == placementInGrid.y && p.x == placementInGrid.x ||
        p.y + 1 == placementInGrid.y && p.x + 1 == placementInGrid.x ||
        p.y - 1 == placementInGrid.y && p.x + 1 == placementInGrid.x ||
        p.y + 1 == placementInGrid.y && p.x - 1 == placementInGrid.x ||
        p.y - 1 == placementInGrid.y && p.x - 1 == placementInGrid.x) {
      return true;
    }
    return false;
  }

  @override
  Future<void> onLoad() async {
    add(EmptyBox());
  }

  @override
  void onTapUp(TapUpEvent event) {
    print('onTapUp');
    print(isLongTap);
    if (!isLongTap) {
      if (hasBomb) {
        add(Bomb()..hit());
        gameRef.gameBloc.add(OnBombHit());
      } else if (bombsAround == 0) {
        add(EmptyBox()..clicked());
        gameRef.gameBloc.add(OnRevealSquare());
        gameRef.gameBloc.add(OnRevealSurroundingSquares(placementInGrid));
      } else {
        gameRef.gameBloc.add(OnRevealSquare());
        add(Number(bombsAround));
      }
      isRevealed = true;
    }
    if (isLongTap && !hasFlag) {
      isLongTap = false;
    }
  }

  @override
  void onLongTapDown(TapDownEvent event) {
    if (isRevealed) return;
    isLongTap = true;
    hasFlag = !hasFlag;
    if (!hasFlag) {
      add(EmptyBox());
    } else {
      add(Flag());
    }
    gameRef.gameBloc.add(OnFlagPressed(hasFlag));
  }

  bool hasBomb;
  int bombsAround;
}
