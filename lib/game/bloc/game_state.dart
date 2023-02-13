part of 'game_bloc.dart';

enum GameStatus {
  dead,
  win,
  playing,
  reset,
}

@immutable
class GameState extends Equatable {
  final int nbFlags;
  final int nbBombs;
  final Vector2? placementInGrid;
  final bool? isBombHit;
  final int revealedSquares;
  final GameStatus gameStatus;

  const GameState.empty()
      : nbFlags = 0,
        nbBombs = 0,
        placementInGrid = null,
        isBombHit = false,
        revealedSquares = 0,
        gameStatus = GameStatus.playing;

  const GameState({
    this.nbFlags = 0,
    this.nbBombs = 0,
    this.placementInGrid,
    this.isBombHit = false,
    this.revealedSquares = 0,
    this.gameStatus = GameStatus.playing,
  });

  GameState copyWith({
    int? nbFlags,
    int? nbBombs,
    Vector2? placementInGrid,
    bool? isBombHit,
    int? revealedSquares,
    GameStatus? gameStatus,
  }) {
    return GameState(
      nbFlags: nbFlags ?? this.nbFlags,
      nbBombs: nbBombs ?? this.nbBombs,
      placementInGrid: placementInGrid,
      isBombHit: isBombHit ?? this.isBombHit,
      revealedSquares: revealedSquares ?? this.revealedSquares,
      gameStatus: gameStatus ?? this.gameStatus,
    );
  }

  @override
  List<Object?> get props => [
        nbFlags,
        placementInGrid,
        isBombHit,
        gameStatus,
        revealedSquares,
      ];
}
