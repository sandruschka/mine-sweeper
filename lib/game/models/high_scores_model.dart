import 'package:json_annotation/json_annotation.dart';
import 'package:mine_sweeper/game/models/high_score_model.dart';

part 'high_scores_model.g.dart';

const String highScoresDataKey = "highScores";

@JsonSerializable()
class HighScores {
  List<HighScore> highScores;

  HighScores(this.highScores);

  factory HighScores.fromJson(Map<String, dynamic> json) =>
      _$HighScoresFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$HighScoresToJson(this);
}
