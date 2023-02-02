import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mine_sweeper/game/bloc/game_bloc.dart';
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

  late Stream clock;
  int seconds = 0;

  @override
  void initState() {
    clock = Stream.periodic(const Duration(seconds: 1));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GameBloc, GameBlocState>(
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(color: Colors.red),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    '${state.nbFlags}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: () {
                    widget.game.gameBloc.add(OnReset());
                  },
                  child: Text(
                    gameStatus[state.gameStatus] ?? '',
                    style: const TextStyle(
                      fontSize: 40,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(color: Colors.red),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: StreamBuilder(
                    stream: clock,
                    builder: (context, snapshot) {
                      seconds++;

                      return Text(
                        '$seconds',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
        listener: (context, state) {});
  }
}

/*class HeaderController extends Component
    with
        HasGameRef<MineSweeperGame>,
        FlameBlocListenable<GameBloc, GameBlocState> {
  @override
  Future<void> onLoad() async {
    add(Smiley());
    return super.onLoad();
  }

  TextPaint textPaint = TextPaint(
    style: const TextStyle(
      fontSize: 12.0,
      fontFamily: 'Awesome Font',
      color: Colors.black,
    ),
  );
  @override
  void render(Canvas canvas) {
    Rect rect = const Rect.fromLTWH(5, 0, 30, 15);
    canvas.drawRect(rect, Paint()..color = const Color(0xFFFF00FF));
    textPaint.render(
      canvas,
      gameRef.gameBloc.state.nbFlags.toString(),
      Vector2(16, 1),
    );
    super.render(canvas);
  }
}*/
