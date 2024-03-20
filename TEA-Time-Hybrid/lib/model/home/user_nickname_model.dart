class UserNicknameModel {
  final String nickname;

  UserNicknameModel(this.nickname);

  factory UserNicknameModel.fromJson(String nickname) {
    return UserNicknameModel(
      nickname,
    );
  }
}