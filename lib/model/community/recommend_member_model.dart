class RecommendMemberModel {
  final int userId;
  final String nickname;
  final String profileImage;
  final int diaryNumber;

  const RecommendMemberModel({
    required this.userId,
    required this.nickname,
    required this.profileImage,
    required this.diaryNumber,
  });

  factory RecommendMemberModel.fromJson(Map<String, dynamic> json) {
    return RecommendMemberModel(
      userId: json["user_id"],
      nickname: json["nickname"],
      profileImage: json["profile_image"],
      diaryNumber: json["diary_number"]
    );
  }
}