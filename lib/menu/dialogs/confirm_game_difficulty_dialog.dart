import 'package:flutter/material.dart';
import 'package:mine_sweeper/game/mine_sweeper_game.dart';

SimpleDialog confirmGameDifficultyDialog(BuildContext context) => SimpleDialog(
      backgroundColor: Colors.white,
      title: const Center(child: Text("Select Difficulty Level")),
      children: [
        SimpleDialogOption(
          onPressed: () {
            Navigator.pop(context, GameDifficulty.beginner);
          },
          child: const Text('Beginner'),
        ),
        SimpleDialogOption(
          onPressed: () {
            Navigator.pop(context, GameDifficulty.easy);
          },
          child: const Text('Easy'),
        ),
        SimpleDialogOption(
          onPressed: () {
            Navigator.pop(context, GameDifficulty.intermediate);
          },
          child: const Text('Intermediate'),
        ),
        SimpleDialogOption(
          onPressed: () {
            Navigator.pop(context, GameDifficulty.expert);
          },
          child: const Text('Expert'),
        ),
      ],
    );
