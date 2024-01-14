class DiaryDetail {
  final int diaryId;
  final String username;
  final String createdAt;
  final String title;
  final String profileImage;
  final String diaryImage;

  DiaryDetail(this.diaryId, this.username, this.createdAt, this.title, this.profileImage, this.diaryImage);

  factory DiaryDetail.fromJson(Map<String, dynamic> json) {
    return DiaryDetail(
      json['diaryId'],
      json['username'],
      json['createdAt'],
      json['title'],
      json['profileImage'],
      json['diaryImage'],
    );
  }
}