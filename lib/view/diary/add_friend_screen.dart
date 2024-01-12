// ignore: file_names
import 'package:flutter/material.dart';

import 'notification_page.dart';

class AddFriendPage extends StatelessWidget {
  const AddFriendPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('친구 추가'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // 알림 페이지로 이동하는 로직을 여기에 구현
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NotificationPage()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'TEA : TIME 에서 추천하는 5명의 회원입니다.',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            // 추천 회원 리스트를 가로로 스크롤 가능하게 표시
            SizedBox(
              height: 120, // 카드의 높이 설정
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5, // 추천 회원의 수, 예시로 5로 설정
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Container(
                      width: 100, // 카드의 너비 설정
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const CircleAvatar(
                            radius: 30, // 아바타 크기 설정
                            backgroundColor: Colors.grey,
                          ),
                          Text('회원 $index'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            // 검색을 통해 찾은 회원 정보 표시
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'TEA : TIME 회원의 닉네임을 검색해보세요!',
              ),
            ),
            // 추가된 부분: 검색 결과를 표시하는 카드
            Container(
              margin: const EdgeInsets.only(top: 8.0), // 카드 상단 마진 부여
              child: const Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey,
                  ),
                  title: Text('검색된 회원 이름'),
                  subtitle: Text('검색된 회원 상세 정보'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
