import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tea_time/view/base/base_screen.dart';
import 'package:tea_time/viewModel/analysis/analysis_diary_view_model.dart';
import 'package:tea_time/widget/base/default_back_appbar.dart';

class DiaryAnalysisScreen extends BaseScreen<AnalysisDiaryViewModel> {
  final int id;
  const DiaryAnalysisScreen(this.id, {super.key});

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
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                            '해당 다이어리의 점수는 ',
                          style: TextStyle(
                            fontSize: 16,
                          )
                        ),
                        Text(
                            viewModel.diaryAnalysisModel?.score.toString() ?? '0',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )
                        ),
                        const Text(
                            '점 입니다.',
                          style: TextStyle(
                            fontSize: 16,
                          )
                        ),
                      ]
                  ),
                  const SizedBox(height: 20),
                  EmotionBar(
                    label: '행복',
                    value: viewModel.diaryAnalysisModel?.emotion.happy ?? 0,
                    color: const Color(0xffebd871),
                  ),
                  EmotionBar(
                    label: '당황',
                    value: viewModel.diaryAnalysisModel?.emotion.embarrassment ?? 0,
                    color: const Color(0xfff4c2cb)
                  ),
                  EmotionBar(
                    label: '슬픔',
                    value: viewModel.diaryAnalysisModel?.emotion.sadness ?? 0,
                    color: const Color(0xff596ac0)
                  ),
                  EmotionBar(
                    label: '불안',
                    value: viewModel.diaryAnalysisModel?.emotion.anxiety ?? 0,
                    color: const Color(0xffc7bdbd)
                  ),
                  EmotionBar(
                    label: '분노',
                    value: viewModel.diaryAnalysisModel?.emotion.anger ?? 70,
                    color: const Color(0xffee6d6d)
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    '오늘의 TEA:Time',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(viewModel.diaryAnalysisModel?.consultant ?? '다이어리 분석 결과가 존재하지 않아요.'),
                ]
            )
          )
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

class EmotionBar extends StatelessWidget {
  final String label;
  final double value;
  final Color color;
  const EmotionBar({super.key, required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: value / 100,
                minHeight: 8,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
