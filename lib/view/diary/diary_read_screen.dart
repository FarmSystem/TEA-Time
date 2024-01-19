import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tea_time/view/base/base_screen.dart';
import 'package:tea_time/viewModel/home/diary_detail_view_model.dart';
import 'package:tea_time/widget/Base/default_back_appbar.dart';

class DiaryReadScreen extends BaseScreen<DiaryDetailViewModel> {
  final int id;
  const DiaryReadScreen(this.id, {super.key});

  @override
  bool get wrapWithOuterSafeArea => false;

  @override
  bool get wrapWithInnerSafeArea => true;

  @override
  Color? get unSafeAreaColor => Colors.white;

  // @override
  // void initViewModel() {
  //   // TODO: implement initViewModel
  //   super.initViewModel();
  //   viewModel.getDiaryDetail(id);
  // }

  @override
  Widget buildBody(BuildContext context) {
    viewModel.getDiaryDetail(id);
    return Obx(() {
      if (viewModel.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      } else {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 100,
                    child: Image(
                      image: NetworkImage(viewModel.diaryDetail?.profileImage ?? ''),
                    ),
                  ),
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            viewModel.diaryDetail?.nickname ?? '히잉',
                          ),
                          Text(
                            DateFormat('yyyy년 MM월 d일').format(viewModel.diaryDetail?.createdAt ?? DateTime.now()),
                          )
                        ]
                    )
                  )
                ]
              ),
              const SizedBox(height: 16),
              Text(
                viewModel.diaryDetail?.content ?? '왜안나왕',
              ),
              const SizedBox(height: 12),
              Image(
                image: NetworkImage(viewModel.diaryDetail?.diaryImage ?? ''),
                width: 300,
                height: 300,
              )
            ]
          )
        );
      }
    });
  }

  @override
  PreferredSize buildAppBar(BuildContext context) {
    return const PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight),
      child: DefaultBackAppBar(title: '다이어리 자세히 보기')
    );
  }
}