import 'package:flutter/material.dart';

import '../base/default_appbar.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: DefaultAppBar(
          title: 'Community',
        ),
      ),
      body: ListView(
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
                    Text('사용자 이름'),
                    Text('작성일자'),
                  ],
                ),
              ],
            ),
          ),

          // 다이어리 제목 부분
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              '다이어리 제목',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                '게시물 텍스트 내용이 들어갈 부분입니다.',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),

          // 다른 게시물들을 추가 예정 (현재 body 내용 전체가 반복되어야 함.)
        ],
      ),
    );
  }
}
