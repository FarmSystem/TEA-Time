class DiaryDetailModel {
  final int diaryId;
  final String title;
  final String profileImage;
  final String nickname;
  final String content;
  final String diaryImage;
  final DateTime createdAt;

  DiaryDetailModel({
    required this.diaryId,
    required this.title,
    required this.profileImage,
    required this.nickname,
    required this.content,
    required this.diaryImage,
    required this.createdAt,
  });

  factory DiaryDetailModel.fromJson(Map<String, dynamic> json) {
    return DiaryDetailModel(
      diaryId: json['diary_id'],
      title: json['title'],
      profileImage: json['profile_image'],
      nickname: json['nickname'],
      content: json['content'],
      diaryImage: json['diary_image'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}