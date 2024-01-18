class DiaryDetailModel {
  final int diaryId;
  final String username;
  final DateTime createdAt;
  final String title;
  final String content;
  final String profileImage;
  final String diaryImage;

  DiaryDetailModel({
    required this.diaryId,
    required this.username,
    required this.createdAt,
    required this.title,
    required this.content,
    required this.profileImage,
    required this.diaryImage
  });

  factory DiaryDetailModel.fromJson(Map<String, dynamic> json) {
    return DiaryDetailModel(
      diaryId: json['diaryId'],
      username: json['username'],
      createdAt: DateTime.parse(json['created_at']),
      title: json['title'],
      content: json['content'],
      profileImage: json['profile_image'],
      diaryImage: json['diary_image'],
    );
  }
}