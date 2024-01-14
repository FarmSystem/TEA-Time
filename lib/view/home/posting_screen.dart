import 'package:flutter/material.dart';
import 'package:tea_time/view/base/base_screen.dart';
import 'package:tea_time/viewModel/home/posting_view_model.dart';
import 'package:tea_time/widget/Base/default_back_appbar.dart';

class PostingScreen extends BaseScreen<PostingViewModel> {
  const PostingScreen({super.key});

  @override
  Widget buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '제목',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                width: 300,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: '제목을 입력하세요',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          Container(
            width: 350,
            height: 405,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const TextField(
              maxLines: null,
              decoration: InputDecoration(
                hintText: '내용을 자유롭게 입력하세요',
                border: InputBorder.none,
              ),
            ),
          ),

          const SizedBox(height: 16),

          Container(
            width: 350,
            height: 80,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.camera_alt, size: 40),
                SizedBox(height: 8),
                Text('사진 업로드'),
              ],
            ),
          ),

          const SizedBox(height: 16), // 간격 조절

          MaterialButton(
            onPressed: () {},
            color: const Color.fromRGBO(210, 232, 223, 1),
            textColor: const Color.fromRGBO(38, 38, 38, 1),
            minWidth: MediaQuery.of(context).size.width * 0.8,
            height: 50,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text("다이어리 작성하기"),
          ),
        ]
      )
    );
  }

  @override
  bool get wrapWithOuterSafeArea => false;

  @override
  bool get wrapWithInnerSafeArea => true;

  @override
  Color? get unSafeAreaColor => Colors.white;

  @override
  PreferredSize buildAppBar(BuildContext context) {
    return const PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight),
      child: DefaultBackAppBar(title: '다이어리 작성'),
    );
  }
}