import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:mine_sweeper/game/bloc/game_bloc.dart';
import 'package:mine_sweeper/game/mine_sweeper_game.dart';

class GameStatusListener extends Component with HasGameRef<MineSweeperGame> {
  @override
  Future<void>? onLoad() async {
    add(
      FlameBlocListener<GameBloc, GameState>(
        listenWhen: (previousState, newState) {
          return newState.gameStatus == GameStatus.reset;
        },
        onNewState: (state) {
          if (state.gameStatus == GameStatus.reset) {
            gameRef.reset();
          }
        },
      ),
    );
  }
}
