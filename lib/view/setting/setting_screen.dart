import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tea_time/view/base/base_screen.dart';
import 'package:tea_time/view/base/base_widget.dart';
import 'package:tea_time/viewModel/setting/user_info_view_model.dart';
import 'package:tea_time/widget/Base/default_appbar.dart';

class SettingScreen extends BaseScreen<UserInfoViewModel> {
  const SettingScreen({super.key});

  @override
  Widget buildBody(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          _UserInfoItem(),
          SizedBox(height: 30),
          _UserLevelItem(),
          SizedBox(height: 30),
          _DiaryTokenItem(),
        ]
      )
    );
  }

  @override
  PreferredSize buildAppBar(BuildContext context) {
    return const PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight),
      child: DefaultAppBar(title: '설정')
    );
  }
}

class _UserInfoItem extends BaseWidget<UserInfoViewModel> {
  const _UserInfoItem();

  @override
  Widget buildView(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
            children: [
              const CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage('assets/images/default.png'),
              ),
              const SizedBox(width: 10),
              Obx(() => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        viewModel.userInfoModel?.nickname ?? '티타임',
                        style: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'Pretendards',
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(38, 38, 38, 1),
                        )
                    ),
                    Text(
                        '총 ${viewModel.userInfoModel?.diaryCount ?? 0}개의 다이어리를 작성하셨습니다.',
                        style: const TextStyle(
                          fontSize: 12,
                          fontFamily: 'Pretendards',
                          color: Color.fromRGBO(38, 38, 38, 1),
                        )
                    ),
                  ]
              ))
            ]
        )
    );
  }
}

class _UserLevelItem extends BaseWidget<UserInfoViewModel> {
  const _UserLevelItem();

  @override
  Widget buildView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Obx(() => Column(
        children: [
        Text('사용자의 레벨은 ${viewModel.userInfoModel?.userLevel ?? 0}입니다.'),
        Text('사용자의 경험치는 ${viewModel.userInfoModel?.userScore ?? 0}입니다.')
      ]
    ))
      ]
    );
  }
}

class _DiaryTokenItem extends BaseWidget<UserInfoViewModel> {
  const _DiaryTokenItem();

  @override
  Widget buildView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(viewModel.diaryTokens.length, (index) {
                final token = viewModel.diaryTokens[index];
                return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(image: NetworkImage(token.diaryImage),
                      width: MediaQuery.of(context).size.width / 3,
                      height: MediaQuery.of(context).size.width / 3),
                    ]
                );
              })

        )
      ]
    );
  }
}

// class _DiaryTokenItem extends StatefulWidget {
//   const _DiaryTokenItem({super.key});
//
//   @override
//   _DiaryTokenItemState createState() => _DiaryTokenItemState();
// }
//
// class _DiaryTokenItemState extends State<_DiaryTokenItem> {
//   ScrollController _scrollController = ScrollController();
//
//   @override
//   void initState() {
//     super.initState();
//     _scrollController.addListener(() {
//       if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
//         viewModel.getDiaryToken(viewModel.currentPage, 9);
//       }
//     });
//   }
// }