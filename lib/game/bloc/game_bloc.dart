import 'package:equatable/equatable.dart';
import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mine_sweeper/game/mine_sweeper_game.dart';

part 'game_bloc_event.dart';
part 'game_bloc_state.dart';

class GameBloc extends Bloc<GameBlocEvent, GameBlocState> {
  GameBloc() : super(const GameBlocState.empty()) {
    on<OnFlagPressed>((event, emit) {
      emit(state.copyWith(
        nbFlags: event.flagAdded ? state.nbFlags + 1 : state.nbFlags - 1,
      ));
    });

    on<OnAddBombCount>((event, emit) {
      emit(state.copyWith(
        nbBombs: event.bombCount,
      ));
    });

    on<OnRevealSurroundingSquares>((event, emit) {
      emit(state.copyWith(
        placementInGrid: event.placementInGrid,
        revealedSquares: state.revealedSquares + 1,
      ));
    });

    on<OnRevealSquare>((event, emit) {
      print('revealedSquares');
      print(state.revealedSquares);
      print('nbBombs');
      print(state.nbBombs);
      if ((state.revealedSquares + 1) + state.nbBombs ==
          (columnCount * rowCount)) {
        emit(
          state.copyWith(
            revealedSquares: state.revealedSquares + 1,
            gameStatus: GameStatus.win,
          ),
        );
      } else {
        emit(state.copyWith(
          revealedSquares: state.revealedSquares + 1,
        ));
      }
    });

    on<OnBombHit>((event, emit) {
      emit(state.copyWith(
        isBombHit: true,
        gameStatus: GameStatus.dead,
      ));
    });

    on<OnReset>((event, emit) {
      emit(state.copyWith(
        gameStatus: GameStatus.reset,
      ));
    });
  }

  @override
  void onTransition(Transition<GameBlocEvent, GameBlocState> transition) {
    // TODO: implement onTransition
    print(transition);
    super.onTransition(transition);
  }
}
