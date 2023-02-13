import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:mine_sweeper/game/models/high_score_model.dart';

AlertDialog displayHighScoresDialog(
        BuildContext context, List<HighScore>? highScores,
        [int place = 0]) =>
    AlertDialog(
      title: Center(child: Text(AppLocalizations.of(context).highScores)),
      actions: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ...?highScores?.map((HighScore highScore) {
              DateFormat dateFormat = DateFormat("dd-MM-yyyy");
              return Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(dateFormat.format(highScore.date)),
                    Text(
                      '${highScore.duration}s',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ],
    );
