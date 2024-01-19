import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tea_time/view/base/base_screen.dart';
import 'package:tea_time/viewModel/analysis/analysis_diary_view_model.dart';
import 'package:tea_time/widget/base/default_back_appbar.dart';

class AnalysisScreen extends BaseScreen<AnalysisDiaryViewModel> {
  final int id;
  const AnalysisScreen(this.id, {super.key});

  @override
  bool get wrapWithOuterSafeArea => false;

  @override
  bool get wrapWithInnerSafeArea => true;

  @override
  Color? get unSafeAreaColor => Colors.white;

  @override
  Widget buildBody(BuildContext context) {
    viewModel.getDiaryAnalysis(id);
    return Obx(() {
      if (viewModel.isLoading.isTrue) {
        return const Center(child: CircularProgressIndicator());
      } else {
        return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '해당 다이어리의 점수는'
                  ),
                  Text(
                    viewModel.diaryAnalysisModel?.score.toString() ?? '0'
                  ),
                  const Text(
                    '점 입니다.'
                  ),
                ]
              ),
              const SizedBox(height: 20),
              const Text(
                '해당 다이어리의 감정은'
              ),
              const SizedBox(height: 20),
              Text(
                '분노 ${viewModel.diaryAnalysisModel?.emotion.anger.toString() ?? '0'}%'
              ),
              Text(
                '슬픔 ${viewModel.diaryAnalysisModel?.emotion.sadness.toString() ?? '0'}%'
              ),
              Text(
                '당황 ${viewModel.diaryAnalysisModel?.emotion.embarrassment.toString() ?? '0'}%'
              ),
              Text(
                '불안 ${viewModel.diaryAnalysisModel?.emotion.anxiety.toString() ?? '0'}%'
              ),
              Text(
                '행복 ${viewModel.diaryAnalysisModel?.emotion.happy.toString() ?? '0'}%'
              ),
              const Text(
                '입니다.'
              ),
              Text(viewModel.diaryAnalysisModel?.consultant ?? '히잉'),
            ]
        );
      }
    } );
  }

  @override
  PreferredSize buildAppBar(BuildContext context) {

    return const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: DefaultBackAppBar(title: '다이어리 분석 보기')
    );
  }
}