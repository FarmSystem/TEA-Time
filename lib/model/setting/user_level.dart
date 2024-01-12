class UserLevel {
  int level;
  int score;

  UserLevel(this.level, this.score);

  factory UserLevel.fromJson(Map<String, dynamic> json) {
    return UserLevel(
      json['level'],
      json['score'],
    );
  }
}