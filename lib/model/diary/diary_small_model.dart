class DiarySmallModel {
  final int id;
  final DateTime date;

  const DiarySmallModel({
    required this.id,
    required this.date,
  });

  factory DiarySmallModel.fromJson(
      Map<String, dynamic> json
       ) {
    return DiarySmallModel(
      id: json["id"],
      date: DateTime.parse(json["created_at"])
    );
  }
}