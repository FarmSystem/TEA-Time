class DiaryAnalysisModel {
  final double score;
  final Emotion emotion;
  final String consultant;

  DiaryAnalysisModel({
    required this.score,
    required this.emotion,
    required this.consultant
});

  factory DiaryAnalysisModel.fromJson(Map<String, dynamic> json) {
    return DiaryAnalysisModel(
      score: json["score"],
      emotion: Emotion.fromJson(json["emotion"]),
      consultant: json["consultant"],
    );
  }
}

class Emotion {
  late final double happy;
  late final double embarrassment;
  late final double anger;
  late final double anxiety;
  late final double sadness;

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