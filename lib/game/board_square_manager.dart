import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:mine_sweeper/game/bloc/game_bloc.dart';
import 'package:mine_sweeper/game/components/components.dart';
import 'package:mine_sweeper/game/game_setup.dart';
import 'package:mine_sweeper/game/mine_sweeper_game.dart';

class BoardSquareManager extends PositionComponent
    with
        TapCallbacks,
        HasGameRef<MineSweeperGame>,
        FlameBlocListenable<GameBloc, GameState> {
  BoardSquareManager({
    this.hasBomb = false,
    this.bombsAround = 0,
    required this.placementInGrid,
    super.position,
  }) : super(size: boxSize);

  final Vector2 placementInGrid;
  bool hasFlag = false;
  bool isRevealed = false;
  bool isLongTap = false;
  late final BoardInfo boardInfo;

  @override
  void onNewState(GameState state) {
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
      if (hasFlag) {
        gameRef.gameBloc.add(OnFlagPressed(false));
        hasFlag = false;
      }
      if (bombsAround == 0) {
        add(EmptyBox()..clicked());
        gameRef.gameBloc.add(OnRevealSquare(
          rowCount: boardInfo.rowCount,
          columnCount: boardInfo.columnCount,
          placementInGrid: placementInGrid,
        ));
      } else {
        gameRef.gameBloc.add(OnRevealSquare(
          rowCount: boardInfo.rowCount,
          columnCount: boardInfo.columnCount,
        ));
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
    boardInfo = gameRef.gameSetup.boardInfo;
    add(EmptyBox());
  }

  @override
  void onTapUp(TapUpEvent event) {
    // Prevent user tap interaction when the game is over
    if (gameRef.gameBloc.state.gameStatus == GameStatus.win ||
        gameRef.gameBloc.state.gameStatus == GameStatus.dead) return;

    if (!isLongTap) {
      if (hasBomb) {
        add(Bomb()..hit());
        gameRef.gameBloc.add(OnBombHit());
      } else if (bombsAround == 0) {
        add(EmptyBox()..clicked());
        gameRef.gameBloc.add(OnRevealSquare(
          rowCount: boardInfo.rowCount,
          columnCount: boardInfo.columnCount,
          placementInGrid: placementInGrid,
        ));
        //gameRef.gameBloc.add(OnRevealSurroundingSquares(placementInGrid));
      } else {
        gameRef.gameBloc.add(OnRevealSquare(
          rowCount: boardInfo.rowCount,
          columnCount: boardInfo.columnCount,
        ));
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
    if (gameRef.gameBloc.state.gameStatus == GameStatus.win ||
        gameRef.gameBloc.state.gameStatus == GameStatus.dead) return;
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
