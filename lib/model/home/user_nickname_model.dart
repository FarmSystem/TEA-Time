class UserNicknameModel {
  String nickname;

  UserNicknameModel(this.nickname);

  factory UserNicknameModel.fromJson(Map<String, dynamic> json) {
    return UserNicknameModel(
      json['nickname']
    );
  }
}