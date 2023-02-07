import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mine_sweeper/game/mine_sweeper_game.dart';
import 'package:mine_sweeper/menu/dialogs/confirm_game_difficulty_dialog.dart';
import 'package:mine_sweeper/routes.gr.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AutoRouter.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Spacer(),
              Container(
                color: Theme.of(context).colorScheme.primary,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset('assets/images/bomb-animation.json',
                        frameRate: FrameRate(2),
                        filterQuality: FilterQuality.low,
                        width: MediaQuery.of(context).size.width / 1.5),
                  ],
                ),
              ),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: () async {
                  GameDifficulty? difficultySelected = await showDialog(
                    context: context,
                    builder: (context) => confirmGameDifficultyDialog(context),
                  );
                  if (difficultySelected != null) {
                    context.router
                        .push(Game(gameDifficulty: difficultySelected));
                  }
                },
                icon: const Icon(Icons.play_arrow),
                label: const Text("Start"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              ),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.format_list_numbered),
                label: const Text("HighScore"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              ),
              const Spacer(flex: 4),
            ],
          ),
        ),
      ),
    );
  }
}
