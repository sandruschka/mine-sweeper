import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:mine_sweeper/game/bloc/game_bloc.dart';
import 'package:mine_sweeper/game/bloc/timer/timer_bloc.dart';
import 'package:mine_sweeper/game/mine_sweeper_game.dart';

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
                      builder: (_) => _confirmResetDialog(), context: context);
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
                '${context.select((TimerBloc bloc) => bloc.state.duration)}', //'${state.duration}',
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
      } else if (state.gameStatus == GameStatus.playing &&
          state.revealedSquares == 1) {
        BlocProvider.of<TimerBloc>(context).add(TimerStarted());
      } else if (state.gameStatus == GameStatus.reset) {
        BlocProvider.of<TimerBloc>(context).add(TimerReset());
      }
    });
  }

  AlertDialog _confirmResetDialog() => AlertDialog(
        title: const Center(child: Text("Restart ? ")),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconsOutlineButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                text: 'Cancel',
                iconData: Icons.cancel_outlined,
                textStyle: const TextStyle(color: Colors.grey),
                iconColor: Colors.grey,
              ),
              IconsButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                text: "Restart",
                iconData: Icons.loop,
                color: Colors.red,
                textStyle: const TextStyle(color: Colors.white),
                iconColor: Colors.white,
              ),
            ],
          ),
        ],
      );
}
