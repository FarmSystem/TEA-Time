import 'package:flutter/material.dart';

import '../base/default_appbar.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({Key? key}) : super(key: key);

  @override
  _CommunityScreenState createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  // 서버에서 받아올 데이터 예시 (나중에 class 파일 따로 만들어서 던질 예정)
  List<Post> posts = [
    Post('사용자1', '2022-01-01', '다이어리 제목 1', '게시물 내용 1'),
    Post('사용자2', '2022-01-02', '다이어리 제목 2', '게시물 내용 2'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: DefaultAppBar(
          title: 'Community',
        ),
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return buildPostItem(posts[index]);
        },
      ),
    );
  }

  Widget buildPostItem(Post post) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // 사용자 프로필 부분
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage:
                    AssetImage('assets/profile_picture.jpg'), // 프로필 이미지
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(post.username),
                  Text(post.date),
                ],
              ),
            ],
          ),
        ),

        // 다이어리 제목 부분
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            post.title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),

        // 게시물 텍스트 내용 부분
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: 302,
            height: 302,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              post.content,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),

        // 구분선 추가
        Divider(height: 1, color: Colors.grey),

        // ...
      ],
    );
  }
}

class Post {
  final String username;
  final String date;
  final String title;
  final String content;

  Post(this.username, this.date, this.title, this.content);
}
