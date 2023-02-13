import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

AlertDialog newHighScoreDialog(BuildContext context, double duration,
        [int place = 0]) =>
    AlertDialog(
      title: Center(child: Text(AppLocalizations.of(context).newHighScore)),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              '${duration}s',
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ],
    );
