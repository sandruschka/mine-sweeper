part of 'game_bloc.dart';

abstract class GameEvent {}

class OnFlagPressed extends GameEvent {
  OnFlagPressed(this.flagAdded);

  final bool flagAdded;

  List<bool> get props => [flagAdded];
}

class OnAddBombCount extends GameEvent {
  OnAddBombCount(this.bombCount);

  final int bombCount;

  List<int> get props => [bombCount];
}

/*class OnRevealSurroundingSquares extends GameEvent {
  OnRevealSurroundingSquares(this.placementInGrid);

  final Vector2 placementInGrid;

  List<Vector2> get props => [placementInGrid];
}*/

class OnRevealSquare extends GameEvent {
  final double rowCount;
  final double columnCount;
  final Vector2? placementInGrid;

  OnRevealSquare({
    required this.rowCount,
    required this.columnCount,
    this.placementInGrid,
  });

  List<Object?> get props => [rowCount, columnCount, placementInGrid];
}

class OnBombHit extends GameEvent {
  List<Object> get props => [];
}

class OnReset extends GameEvent {
  List<Object> get props => [];
}
