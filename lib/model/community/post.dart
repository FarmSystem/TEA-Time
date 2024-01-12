class Post {
  final int diaryId;
  final String username;
  final String createdAt;
  final String title;
  final String profileImage;
  final String diaryImage;

  Post(this.diaryId, this.username, this.createdAt, this.title, this.profileImage, this.diaryImage);

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      json['diaryId'],
      json['username'],
      json['createdAt'],
      json['title'],
      json['profileImage'],
      json['diaryImage'],
    );
  }
}