import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mine_sweeper/game/bloc/game_bloc.dart';
import 'package:mine_sweeper/game/header/header.dart';
import 'package:mine_sweeper/game/mine_sweeper_game.dart';

void main() {
  runApp(
    const MediaQuery(
      data: MediaQueryData(),
      child: MaterialApp(
        home: GamePage(),
      ),
    ),
  );
}

class GamePage extends StatelessWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GameBloc>(create: (_) => GameBloc()),
      ],
      child: Builder(builder: (context) {
        final MineSweeperGame game = MineSweeperGame(
          gameBloc: context.read<GameBloc>(),
        );
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Header(game),
          ),
          body: SafeArea(
            child: Game(game),
          ),
        );
      }),
    );
  }
}

class Game extends StatelessWidget {
  final MineSweeperGame game;
  const Game(this.game, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: game,
    );
  }
}
