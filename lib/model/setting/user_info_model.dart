class UserInfoModel {
  final String nickname;
  final String introduction;
  final String profileImageUrl;
  final int diaryCount;
  final int userLevel;
  final int userScore;

  UserInfoModel({
    required this.nickname,
    required this.introduction,
    required this.profileImageUrl,
    required this.diaryCount,
    required this.userLevel,
    required this.userScore,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json) {
    return UserInfoModel(
        nickname: json['nickname'],
        introduction: json['introduction'],
        profileImageUrl: json['profile_image'],
        diaryCount: json['diary_count'],
        userLevel: json['user_level'],
        userScore: json['user_score'],
    );
  }
}