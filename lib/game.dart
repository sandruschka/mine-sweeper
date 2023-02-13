import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mine_sweeper/game/bloc/game_bloc.dart';
import 'package:mine_sweeper/game/game_setup.dart';
import 'package:mine_sweeper/game/header/header.dart';
import 'package:mine_sweeper/game/mine_sweeper_game.dart';

class Game extends StatelessWidget {
  final GameDifficulty gameDifficulty;
  const Game({required this.gameDifficulty, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MineSweeperGame game = MineSweeperGame(
      gameBloc: context.read<GameBloc>(),
      gameSetup: GameSetup(gameDifficulty: gameDifficulty),
    );
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Header(game),
          ),
          body: SafeArea(
            child: GameWidget(
              game: game,
            ),
          ),
        ),
      ],
    );
  }
}
