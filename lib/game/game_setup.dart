import 'package:mine_sweeper/game/mine_sweeper_game.dart';

class BoardInfo {
  final double squareSize = 17;
  final double columnCount;
  final double rowCount;
  final int bombProbability;
  late final double boardWidth;
  late final double boardHeight;
  BoardInfo({
    required this.columnCount,
    required this.rowCount,
    required this.bombProbability,
  }) {
    boardWidth = squareSize * columnCount;
    boardHeight = squareSize * rowCount;
  }
}

class GameSetup {
  final difficultyMap = <GameDifficulty, BoardInfo>{
    GameDifficulty.beginner: BoardInfo(
      columnCount: 5,
      rowCount: 10,
      bombProbability: 2,
    ),
    GameDifficulty.easy: BoardInfo(
      columnCount: 7,
      rowCount: 14,
      bombProbability: 3,
    ),
    GameDifficulty.intermediate: BoardInfo(
      columnCount: 10,
      rowCount: 20,
      bombProbability: 4,
    ),
    GameDifficulty.expert: BoardInfo(
      columnCount: 15,
      rowCount: 30,
      bombProbability: 5,
    ),
  };

  final GameDifficulty gameDifficulty;

  late final BoardInfo boardInfo;
  GameSetup({this.gameDifficulty = GameDifficulty.beginner}) {
    boardInfo = difficultyMap[gameDifficulty]!;
  }
}
