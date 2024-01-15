import 'package:flutter/material.dart';
import 'package:tea_time/view/base/base_screen.dart';
import 'package:tea_time/viewModel/home/diary_detail_view_model.dart';
import 'package:tea_time/widget/Base/default_back_appbar.dart';

class DiaryDetailScreen extends BaseScreen<DiaryDetailViewModel> {
  const DiaryDetailScreen({super.key});

  @override
  Widget buildBody(BuildContext context) {
    return Container();
  }

  @override
  PreferredSize buildAppBar(BuildContext context) {
    return const PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight),
      child: DefaultBackAppBar(title: '다이어리 자세히 보기')
    );
  }
}