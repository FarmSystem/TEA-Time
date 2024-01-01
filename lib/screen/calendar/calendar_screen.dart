import 'package:flutter/material.dart';
import 'package:tea_time/screen/base/default_back_appbar.dart';

import '../base/default_appbar.dart';
import 'writing_form.dart'; // 글쓰기 폼 페이지를 import

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  final String username = "티타임";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: DefaultAppBar(
          title: 'Calendar',
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              '안녕하세요 $username님 :)',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: 4, // 임의의 아이템 개수
              itemBuilder: (BuildContext context, int index) {
                // 여기에 이미지 파일을 넣을 수 있는 Box 컴포넌트를 만들어 추가
                return Container(
                  width: 150,
                  height: 150,
                  margin: const EdgeInsets.all(8),
                  color: Colors.grey, // 임의의 색상
                );
              },
            ),
          ),
          SizedBox(
            width: 324,
            height: 56,
            child: ElevatedButton(
              onPressed: () {
                // 글쓰기 폼 페이지로 이동
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WritingFormPage()),
                );
              },
              child: Text('다이어리 작성하기'),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // floating 버튼 클릭 시 help 페이지로 이동
        },
        child: Icon(Icons.help),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
