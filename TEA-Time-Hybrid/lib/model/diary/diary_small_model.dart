class DiarySmallModel {
  final int id;
  final DateTime date;
  final double emotionScore;

  const DiarySmallModel({
    required this.id,
    required this.date,
    required this.emotionScore,
  });

  factory DiarySmallModel.fromJson(
      Map<String, dynamic> json
       ) {
    return DiarySmallModel(
      id: json["id"],
      date: DateTime.parse(json["created_at"]),
      emotionScore: json["emotion_score"],
    );
  }

  @override
  String toString() {
    // TODO: implement toString
    return "id: $id,\ndate: $date,\nemotionScore: $emotionScore";
  }
}