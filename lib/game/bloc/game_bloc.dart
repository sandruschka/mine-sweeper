import 'package:equatable/equatable.dart';
import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(const GameState.empty()) {
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

    on<OnRevealSquare>((event, emit) {
      bool isWon = (state.revealedSquares + 1) + state.nbBombs ==
          (event.columnCount * event.rowCount);
      bool isReset = state.gameStatus == GameStatus.reset;
      emit(
        state.copyWith(
          placementInGrid: event.placementInGrid,
          revealedSquares: state.revealedSquares + 1,
          gameStatus: isWon
              ? GameStatus.win
              : isReset
                  ? GameStatus.playing
                  : state.gameStatus,
        ),
      );
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
        isBombHit: false,
        nbFlags: 0,
        revealedSquares: 0,
        placementInGrid: null,
      ));
      print("state: $state");
    });
  }

  @override
  void onTransition(Transition<GameEvent, GameState> transition) {
    // TODO: implement onTransition
    print(transition.nextState);

    super.onTransition(transition);
  }
}
