import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tea_time/view/analysis/diary_analysis_screen.dart';
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

  @override
  Widget buildBody(BuildContext context) {
    viewModel.getDiaryDetail(id);
    return Obx(() {
      if (viewModel.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      } else {
        return SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 50,
                            child: ClipOval(
                              child: Image(
                                image: NetworkImage(viewModel.diaryDetail?.profileImage ?? ''),
                                width: 50,
                                height: 50,
                              )
                            )
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      viewModel.diaryDetail?.nickname ?? '히잉',
                                      style: const TextStyle(
                                        fontSize: 16,
                                      )
                                    ),
                                    Text(
                                      DateFormat('yyyy년 MM월 d일').format(viewModel.diaryDetail?.createdAt ?? DateTime.now()),
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey
                                      )
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
                    ),
                  ]
              )
          ),
        );
      }
    });
  }

  @override
  Widget? get buildFloatingActionButton => Container(
    padding: const EdgeInsets.all(16),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          onPressed: () {
            Get.to(() => DiaryAnalysisScreen(viewModel.diaryDetail!.diaryId));
          },
          backgroundColor: const Color.fromRGBO(210, 232, 223, 1),
          child: const Icon(Icons.align_vertical_bottom),
        ),
      ]
    )
  );

  @override
  PreferredSize buildAppBar(BuildContext context) {

    return const PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight),
      child: DefaultBackAppBar(title: '다이어리 자세히 보기')
    );
  }
}