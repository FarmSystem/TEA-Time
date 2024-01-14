import 'dart:ffi';

class DiaryAnalysis {
  final Float score;
  final Emotion emotion;

  DiaryAnalysis(this.score, this.emotion);

  factory DiaryAnalysis.fromJson(Map<String, dynamic> json) {
    return DiaryAnalysis(
      json["score"],
      Emotion.fromJson(json["emotion"]),
    );
  }
}

class Emotion {
  late final Float happy;
  late final Float embarrassment;
  late final Float anger;
  late final Float anxiety;
  late final Float sadness;

  Emotion(this.happy, this.embarrassment, this.anger, this.anxiety, this.sadness);

  factory Emotion.fromJson(Map<String, dynamic> json) {
    return Emotion(
      json["happy"],
      json["embarrassment"],
      json["anger"],
      json["anxiety"],
      json["sadness"],
    );
  }
}