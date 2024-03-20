import 'package:flutter/material.dart';
import 'package:tea_time/model/types/time_period.dart';
import 'package:tea_time/view/analysis/widgets/emotion_chart.dart';
import 'package:tea_time/view/base/base_screen.dart';
import 'package:tea_time/viewModel/analysis/analysis_view_model.dart';
import 'package:tea_time/widget/base/default_appbar.dart';

class AnalysisScreen extends BaseScreen<AnalysisViewModel> {
  const AnalysisScreen({super.key});

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return const PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight),
      child: DefaultAppBar(
        title: '감정분석',
      ),
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EmotionChart(period: TimePeriod.seven),
            SizedBox(height: 16),
            EmotionChart(period: TimePeriod.thirty),
          ],
        ),
      ),
    );
  }
}
