import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/audio_pool.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart';
import 'package:mine_sweeper/game/bloc/game_bloc.dart';
import 'package:mine_sweeper/game/board_square_manager.dart';
import 'package:mine_sweeper/game/game_setup.dart';
import 'package:mine_sweeper/game/game_status_listener.dart';

enum GameDifficulty { beginner, easy, intermediate, expert, custom }

final Vector2 boxSize = Vector2(17, 17);

class GameBoardCreator extends Component with HasGameRef<MineSweeperGame> {
  @override
  Future<void>? onLoad() async {
    final World world = World();

    int maxProbability = 15;
    Random random = Random();

    late int bombCount = 0;
    final double rowCount = gameRef.gameSetup.boardInfo.rowCount;
    final double columnCount = gameRef.gameSetup.boardInfo.columnCount;

    List<List<BoardSquareManager>> gameBoard = [];

    List.generate(columnCount.toInt(), (i) {
      List<BoardSquareManager> boardColumn =
          List.generate(rowCount.toInt(), (j) {
        int randomNumber = random.nextInt(maxProbability);
        bool hasBomb =
            randomNumber < gameRef.gameSetup.boardInfo.bombProbability;
        bombCount = hasBomb ? bombCount + 1 : bombCount;

        return BoardSquareManager(
          hasBomb: hasBomb,
          position: Vector2(i * boxSize.x, (j) * boxSize.y),
          placementInGrid: Vector2(i.toDouble(), j.toDouble()),
        );
      });
      gameBoard.add(boardColumn);
    });

    _calculateBombsAround(gameBoard, rowCount, columnCount);
    for (var element in gameBoard) {
      world.addAll(element);
    }

    int zoomCount = 0;

    add(world);

    final camera = CameraComponent(world: world)
      ..viewfinder.visibleGameSize = Vector2(
          gameRef.gameSetup.boardInfo.boardWidth,
          gameRef.gameSetup.boardInfo.boardHeight)
      ..viewfinder.position = Vector2(0, 0)
      ..viewfinder.anchor = Anchor.topLeft;
    await add(camera);

    gameRef.gameBloc.add(OnAddBombCount(bombCount));
  }

  _calculateBombsAround(
    List<List<BoardSquareManager>> board,
    double rowCount,
    double columnCount,
  ) {
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

class MineSweeperWorld extends Component with HasGameRef<MineSweeperGame> {
  final GameBloc gameBloc;
  MineSweeperWorld(this.gameBloc);
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(
      FlameMultiBlocProvider(providers: [
        FlameBlocProvider<GameBloc, GameState>.value(
          value: gameBloc,
        ),
      ], children: [
        GameStatusListener(),
        GameBoardCreator(),
      ]),
    );
  }
}

class MineSweeperGame extends FlameGame with HasTappableComponents {
  MineSweeperGame({
    required this.gameBloc,
    required this.gameSetup,
  });

  @override
  double get longTapDelay => 0.200;

  @override
  Color backgroundColor() => const Color.fromRGBO(0, 0, 0, 1);

  final GameBloc gameBloc;
  final GameSetup gameSetup;
  late AudioPool pool;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    await FlameAudio.audioCache.load('music-tempo.mp3');
    //_startBackgroundMusic();

    await Flame.images.load('minesweeper-sprite.png');

    await add(MineSweeperWorld(gameBloc));
  }

  void _startBackgroundMusic() {
    FlameAudio.bgm.initialize();
    FlameAudio.bgm.play('music-tempo.mp3');
  }

  _onCameraZoom() {
    /* camera.viewfinder.visibleGameSize =
        Vector2(boardWidth + 10, boardHeight + 10);*/
  }

  reset() {
    removeWhere((component) => component is MineSweeperWorld);
    add(MineSweeperWorld(gameBloc));
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
