import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tea_time/util/function/log_on_dev.dart';
import 'package:tea_time/util/function/user_level.dart';
import 'package:tea_time/view/base/base_screen.dart';
import 'package:tea_time/view/base/base_widget.dart';
import 'package:tea_time/view/diary/diary_read_screen.dart';
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
          _DiaryTokenItemTest(),
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
        child: Obx(() => Row(
            children: [
              ClipOval(
                child: Image(image: NetworkImage(viewModel.userInfoModel?.profileImageUrl ?? ''),
                  width: 50,
                  height: 50,
                ),
              ),
              const SizedBox(width: 10),
              Column(
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
                    Text(
                      '${viewModel.userInfoModel?.introduction}' ?? '자기소개가 없습니다.',
                    )
                  ]
              )
            ]
        ))
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
          crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            getLevelAsset(viewModel.userInfoModel?.userLevel ?? 1),
            width: 100,
            height: 100,
          ),
          const SizedBox(height: 10),
        Text('${viewModel.userInfoModel?.nickname}님의 레벨은 ${viewModel.userInfoModel?.userLevel ?? 1}레벨 입니다.'),
      ]
    ))
      ]
    );
  }
}

class _DiaryTokenItemTest extends StatefulWidget {
  const _DiaryTokenItemTest();

  @override
  _DiaryTokenItemTestState createState() => _DiaryTokenItemTestState();
}

class _DiaryTokenItemTestState extends State<_DiaryTokenItemTest> {
  final ScrollController _scrollController = ScrollController();
  final UserInfoViewModel viewModel = Get.find<UserInfoViewModel>();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      viewModel.getDiaryToken(viewModel.currentPage, 3);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Obx(() {
          if (viewModel.isLoading.isTrue) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                shrinkWrap: true,
                controller: _scrollController,
                itemCount: viewModel.diaryTokens.length,
                itemBuilder: (context, index) {
                  final token = viewModel.diaryTokens[index];
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          child: Image(image: NetworkImage(token.diaryImage),
                              width: MediaQuery.of(context).size.width / 3,
                              height: MediaQuery.of(context).size.width / 3),
                          onTap: () {
                            Get.to(() => DiaryReadScreen(token.diaryId));
                          },
                        )
                      ]
                  );
                }
            );
          }
        })
      ]
    );
  }
}