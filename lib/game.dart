import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mine_sweeper/game/bloc/game_bloc.dart';
import 'package:mine_sweeper/game/game_setup.dart';
import 'package:mine_sweeper/game/header/header.dart';
import 'package:mine_sweeper/game/mine_sweeper_game.dart';

/*
class Game extends StatefulWidget {
  final GameDifficulty gameDifficulty;
  const Game({required this.gameDifficulty, Key? key}) : super(key: key);

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  late bool _isLoading = true;
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3)).then((value) {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final MineSweeperGame game = MineSweeperGame(
      gameBloc: context.read<GameBloc>(),
      gameSetup: GameSetup(gameDifficulty: widget.gameDifficulty),
    );
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            title: Header(game),
          ),
          body: SafeArea(
            child: GameWidget(
              game: game,
            ),
          ),
        ),
        if (_isLoading)
          Container(
            color: Theme.of(context).colorScheme.primary,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('assets/images/bomb-animation.json'),
              ],
            ),
          ),
      ],
    );
  }
}
*/

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
            backgroundColor: Colors.white,
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
