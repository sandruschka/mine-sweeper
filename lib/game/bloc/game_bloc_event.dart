part of 'game_bloc.dart';

abstract class GameBlocEvent {}

class OnFlagPressed extends GameBlocEvent {
  OnFlagPressed(this.flagAdded);

  final bool flagAdded;

  List<bool> get props => [flagAdded];
}

class OnAddBombCount extends GameBlocEvent {
  OnAddBombCount(this.bombCount);

  final int bombCount;

  List<int> get props => [bombCount];
}

class OnRevealSurroundingSquares extends GameBlocEvent {
  OnRevealSurroundingSquares(this.placementInGrid);

  final Vector2 placementInGrid;

  List<Vector2> get props => [placementInGrid];
}

class OnRevealSquare extends GameBlocEvent {
  OnRevealSquare();

  List<Object> get props => [];
}

class OnBombHit extends GameBlocEvent {
  List<Object> get props => [];
}

class OnReset extends GameBlocEvent {
  List<Object> get props => [];
}
