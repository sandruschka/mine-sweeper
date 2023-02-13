import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';

AlertDialog confirmResetDialog(BuildContext context) => AlertDialog(
      title: Center(child: Text(AppLocalizations.of(context).restart)),
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
