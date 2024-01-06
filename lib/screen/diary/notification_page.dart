import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

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
        title: const Text('알림'),
      ),
      body: ListView.builder(
        itemCount: 5, // 알림의 갯수, 예시로 5개를 설정했습니다.
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey,
              // 알림 아이콘 혹은 사용자의 이미지가 들어갈 수 있습니다.
            ),
            title: Text('네이버의 최신회원 데이터에 날짜를 남겼어요.'),
            subtitle: Text('202X.XX.XX.'),
            // 여기에 날짜 형식에 맞는 실제 데이터를 넣어야 합니다.
            onTap: () {
              // 알림을 탭했을 때의 동작을 여기에 구현합니다.
            },
          );
        },
      ),
    );
  }
}
