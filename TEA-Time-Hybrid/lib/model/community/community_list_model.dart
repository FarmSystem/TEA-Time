class CommunityListModel {
  final int userId;
  final int diaryId;
  final String nickname;
  final String profileImage;
  final DateTime createdAt;
  final String title;
  final String diaryImage;

  const CommunityListModel({
    required this.userId,
    required this.diaryId,
    required this.nickname,
    required this.profileImage,
    required this.createdAt,
    required this.title,
    required this.diaryImage,
  });

  factory CommunityListModel.fromJson(Map<String, dynamic> json) {
    return CommunityListModel(
      userId: json["user_id"],
      diaryId: json["diary_id"],
      nickname: json["nickname"],
      profileImage: json["profile_image"],
      createdAt: DateTime.parse(json["created_at"]),
      title: json["title"],
      diaryImage: json["diary_image"],
    );
  }
}