import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:mine_sweeper/game/bloc/game_bloc.dart';
import 'package:mine_sweeper/game/board_square_controller.dart';

final Vector2 boxSize = Vector2(17, 17);

class GameBoardCreator extends Component with HasGameRef<MineSweeperGame> {
  @override
  Future<void>? onLoad() async {
    final World world = World();

    int bombProbability = 2;
    int maxProbability = 15;
    Random random = Random();

    late int bombCount = 0;

    List<List<BoardSquareController>> gameBoard = [];

    List.generate(columnCount.toInt(), (i) {
      List<BoardSquareController> boardColumn =
          List.generate(rowCount.toInt(), (j) {
        int randomNumber = random.nextInt(maxProbability);
        bool hasBomb = randomNumber < bombProbability;
        bombCount = hasBomb ? bombCount + 1 : bombCount;

        return BoardSquareController(
          hasBomb: hasBomb,
          position: Vector2(i * boxSize.x, (j) * boxSize.y),
          placementInGrid: Vector2(i.toDouble(), j.toDouble()),
        );
      });
      gameBoard.add(boardColumn);
    });

    _calculateBombsAround(gameBoard);
    for (var element in gameBoard) {
      world.addAll(element);
    }

    double boardWidth = 17 * columnCount;
    double boardHeight = 17 * rowCount;
    int zoomCount = 0;

    add(world);

    final camera = CameraComponent(world: world)
      ..viewfinder.visibleGameSize = Vector2(boardWidth, boardHeight)
      ..viewfinder.position = Vector2(0, 0)
      ..viewfinder.anchor = Anchor.topLeft;
    await add(camera);

    gameRef.gameBloc.add(OnAddBombCount(bombCount));
  }

  _calculateBombsAround(List<List<BoardSquareController>> board) {
    for (int i = 0; i < columnCount; i++) {
      for (int j = 0; j < rowCount; j++) {
        if (i > 0 && j > 0) {
          if (board[i - 1][j - 1].hasBomb) {
            board[i][j].bombsAround++;
          }
        }

        if (i > 0) {
          if (board[i - 1][j].hasBomb) {
            board[i][j].bombsAround++;
          }
        }

        if (i > 0 && j < rowCount - 1) {
          if (board[i - 1][j + 1].hasBomb) {
            board[i][j].bombsAround++;
          }
        }

        if (j > 0) {
          if (board[i][j - 1].hasBomb) {
            board[i][j].bombsAround++;
          }
        }

        if (j < rowCount - 1) {
          if (board[i][j + 1].hasBomb) {
            board[i][j].bombsAround++;
          }
        }

        if (i < columnCount - 1 && j > 0) {
          if (board[i + 1][j - 1].hasBomb) {
            board[i][j].bombsAround++;
          }
        }

        if (i < columnCount - 1) {
          if (board[i + 1][j].hasBomb) {
            board[i][j].bombsAround++;
          }
        }

        if (i < columnCount - 1 && j < rowCount - 1) {
          if (board[i + 1][j + 1].hasBomb) {
            board[i][j].bombsAround++;
          }
        }
      }
    }
  }
}

class GameStatusController extends Component with HasGameRef<MineSweeperGame> {
  @override
  Future<void>? onLoad() async {
    add(
      FlameBlocListener<GameBloc, GameBlocState>(
        listenWhen: (previousState, newState) {
          return /*previousState.gameStatus != newState.gameStatus &&*/
              newState.gameStatus == GameStatus.reset;
        },
        onNewState: (state) {
          gameRef.children.forEach((element) {
            element.children.forEach((element) {
              print(element);
            });
          });
        },
      ),
    );
  }
}

const double columnCount = 5; //10;
const double rowCount = 9; //18;

class MineSweeperGame extends FlameGame with HasTappableComponents {
  MineSweeperGame({required this.gameBloc});

  @override
  Color backgroundColor() => const Color.fromRGBO(0, 0, 0, 1);

  final GameBloc gameBloc;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    await Flame.images.load('minesweeper-sprite.png');

    await add(
      FlameMultiBlocProvider(providers: [
        FlameBlocProvider<GameBloc, GameBlocState>.value(
          value: gameBloc,
        ),
      ], children: [
        GameStatusController(),
        GameBoardCreator(),
      ]),
    );
  }

  _onCameraZoom() {
    /* camera.viewfinder.visibleGameSize =
        Vector2(boardWidth + 10, boardHeight + 10);*/
  }
}

Sprite mineSweeperSprite({
  required double x,
  required double y,
  required double width,
  required double height,
}) {
  return Sprite(
    Flame.images.fromCache('minesweeper-sprite.png'),
    srcPosition: Vector2(x, y),
    srcSize: Vector2(width, height),
  );
}
