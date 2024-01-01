import 'package:flutter/material.dart';

class WritingFormPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('다이어리 작성하기'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1번 child
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('제목'),
                Container(
                  width: 200, // 수정 가능한 사이즈
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: '제목을 입력하세요',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16), // 간격 조절

            // 2번 child
            Container(
              width: 350,
              height: 405,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey), // 테두리 색상 지정
                borderRadius: BorderRadius.circular(8), // 테두리 모서리 둥글게
              ),
              child: TextField(
                maxLines: null, // 여러 줄 입력 가능
                decoration: InputDecoration(
                  hintText: '내용을 자유롭게 입력하세요',
                  border: InputBorder.none, // 기존 테두리를 무시하도록 함
                ),
              ),
            ),
            SizedBox(height: 16), // 간격 조절

            // 3번 child
            Container(
              width: 350,
              height: 160,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.camera_alt, size: 40),
                  SizedBox(height: 8),
                  Text('사진 업로드'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
