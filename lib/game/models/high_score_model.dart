import 'package:json_annotation/json_annotation.dart';

part 'high_score_model.g.dart';

@JsonSerializable()
class HighScore {
  final double duration;
  final DateTime date;

  HighScore(
    this.duration,
    this.date,
  );

  factory HighScore.fromJson(Map<String, dynamic> json) =>
      _$HighScoreFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$HighScoreToJson(this);
}
