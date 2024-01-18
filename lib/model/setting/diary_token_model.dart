class DiaryTokenModel {
  final int diaryId;
  final String diaryImage;

  DiaryTokenModel({
    required this.diaryId,
    required this.diaryImage,
  });

  factory DiaryTokenModel.fromJson(Map<String, dynamic> json) {
    return DiaryTokenModel(
      diaryId: json["diary_id"],
      diaryImage: json["diary_image"]
    );
  }
}