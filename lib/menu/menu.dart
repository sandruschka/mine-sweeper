import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lottie/lottie.dart';
import 'package:mine_sweeper/di/injector.dart';
import 'package:mine_sweeper/game/data_cache_manager.dart';
import 'package:mine_sweeper/game/dialogs/confirm_game_difficulty_dialog.dart';
import 'package:mine_sweeper/game/dialogs/display_high_scores_dialog.dart';
import 'package:mine_sweeper/game/mine_sweeper_game.dart';
import 'package:mine_sweeper/game/models/high_scores_model.dart';
import 'package:mine_sweeper/routes.gr.dart';

class Menu extends StatelessWidget {
  Menu({Key? key}) : super(key: key);
  final dataCacheManager = getIt<DataCacheManager>();

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
                label: Text(AppLocalizations.of(context).start),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () async {
                  Map<String, dynamic>? highScoresMap =
                      await dataCacheManager.retrieveData(highScoresDataKey);
                  if (highScoresMap != null) {
                    showDialog(
                      context: context,
                      builder: (context) => displayHighScoresDialog(context,
                          HighScores.fromJson(highScoresMap).highScores),
                    );
                  }
                },
                icon: const Icon(Icons.format_list_numbered),
                label: Text(AppLocalizations.of(context).highScores),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              ),
              if (kDebugMode)
                ElevatedButton.icon(
                  onPressed: () async {
                    dataCacheManager.flushData();
                  },
                  icon: const Icon(Icons.delete),
                  label: Text("Delete HighScores"),
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.white),
                ),
              const Spacer(flex: 4),
            ],
          ),
        ),
      ),
    );
  }
}
