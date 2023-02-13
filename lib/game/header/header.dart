import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mine_sweeper/di/injector.dart';
import 'package:mine_sweeper/game/bloc/game_bloc.dart';
import 'package:mine_sweeper/game/bloc/timer/timer_bloc.dart';
import 'package:mine_sweeper/game/data_cache_manager.dart';
import 'package:mine_sweeper/game/dialogs/new_high_score_dialog.dart';
import 'package:mine_sweeper/game/dialogs/reset_confirmation_dialog.dart';
import 'package:mine_sweeper/game/mine_sweeper_game.dart';
import 'package:mine_sweeper/game/models/high_score_model.dart';
import 'package:mine_sweeper/game/models/high_scores_model.dart';

class Header extends StatefulWidget {
  final MineSweeperGame game;
  const Header(this.game, {Key? key}) : super(key: key);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  Map<GameStatus, String> gameStatus = {
    GameStatus.playing: '🙂',
    GameStatus.reset: '🙂',
    GameStatus.dead: '😵',
    GameStatus.win: '😎',
  };

  late Stream? clock;
  int seconds = 0;
  final dataCacheManager = getIt<DataCacheManager>();

  @override
  void initState() {
    clock = Stream.periodic(const Duration(seconds: 1));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GameBloc, GameState>(builder: (context, state) {
      return Row(
        children: [
          IconButton(
            padding: EdgeInsets.zero,
            icon: const Icon(Icons.menu),
            onPressed: () {
              BlocProvider.of<TimerBloc>(context).add(TimerStop());
              BlocProvider.of<TimerBloc>(context).add(TimerReset());
              context.router.pop();
            },
          ),
          const Spacer(),
          Container(
            decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(color: Colors.red),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                '${state.nbBombs - state.nbFlags}',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ),
          const Spacer(),
          Expanded(
            child: TextButton(
              onPressed: () async {
                bool? reset = true;
                if (state.gameStatus == GameStatus.playing) {
                  reset = await showDialog<bool>(
                      builder: (context) => confirmResetDialog(context),
                      context: context);
                }

                if (reset == true) {
                  widget.game.gameBloc.add(OnReset());
                }
              },
              child: Text(
                gameStatus[state.gameStatus] ?? '',
                style: const TextStyle(
                  fontSize: 40,
                ),
              ),
            ),
          ),
          const Spacer(),
          Container(
            decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(color: Colors.red),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                context.select((TimerBloc bloc) {
                  return (bloc.state.duration * 100).toStringAsFixed(1);
                }),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ),
          const Spacer(
            flex: 2,
          ),
        ],
      );
    }, listener: (context, state) {
      if (state.gameStatus == GameStatus.dead ||
          state.gameStatus == GameStatus.win) {
        BlocProvider.of<TimerBloc>(context).add(TimerStop());
        if (state.gameStatus == GameStatus.win &&
            ModalRoute.of(context)?.isCurrent == true) {
          saveHighScore(BlocProvider.of<TimerBloc>(context).state.duration);
        }
      } else if (state.gameStatus == GameStatus.playing &&
          state.revealedSquares == 1) {
        BlocProvider.of<TimerBloc>(context).add(TimerStarted());
      } else if (state.gameStatus == GameStatus.reset) {
        BlocProvider.of<TimerBloc>(context).add(TimerReset());
      }
    });
  }

  saveHighScore(double duration) async {
    HighScores highScores;
    if (await dataCacheManager.doesDataExist(highScoresDataKey) == true) {
      Map<String, dynamic> highScoresMap =
          await dataCacheManager.retrieveData(highScoresDataKey);
      highScores = HighScores.fromJson(highScoresMap);
    } else {
      highScores = HighScores([]);
    }

    HighScore highScore = HighScore((duration * 100), DateTime.now());

    highScores.highScores.add(highScore);
    dataCacheManager.saveData(highScoresDataKey, highScores.toJson());
    showDialog(
      context: context,
      builder: (context) => newHighScoreDialog(context, highScore.duration),
    );
  }
}
