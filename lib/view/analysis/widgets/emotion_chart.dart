import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tea_time/model/types/time_period.dart';
import 'package:tea_time/view/base/base_widget.dart';
import 'package:tea_time/viewModel/analysis/analysis_view_model.dart';

part 'p_emotion_chart.dart';

class EmotionChart extends BaseWidget<AnalysisViewModel> {
  const EmotionChart({super.key, required this.period});

  final TimePeriod period;

  @override
  Widget buildView(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        border: Border.all(color: const Color(0x5554B492)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              color: Color(0x5554B492),
            ),
            child: Center(
              child: Text(
                '${period.value}일간의 감정',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Obx(() {
            if (viewModel.isLoading) {
              return const SizedBox(
                height: 270,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Color(0xff54B492),
                  ),
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: AspectRatio(
                aspectRatio: 1.5,
                child: LineChart(
                  LineChartData(
                    // 차트 배경색 설정
                    backgroundColor: Colors.transparent,

                    // 격자 설정
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: true,
                      horizontalInterval: 1,
                      verticalInterval: 1,
                      getDrawingHorizontalLine: drawingHorizontalLine,
                      getDrawingVerticalLine: drawingVerticalLine,
                    ),

                    // 라벨 설정
                    titlesData: FlTitlesData(
                      show: true,
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 1,
                          getTitlesWidget: leftTitleWidgets,
                        ),
                      ),
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 30,
                          interval: 1,
                          getTitlesWidget: bottomTitleWidgets,
                        ),
                      ),
                      leftTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),

                    // 터치 설정
                    lineTouchData: const LineTouchData(
                      enabled: false,
                    ),

                    borderData: FlBorderData(
                      show: false,
                      border: Border.all(color: const Color(0xff37434d)),
                    ),
                    minX: 0,
                    maxX: period.value.toDouble() + 0.3,
                    minY: 0,
                    maxY: 100, // 점수 범위에 따라 조절
                    lineBarsData: [
                      LineChartBarData(
                        spots: period == TimePeriod.thirty
                            ? viewModel.monthEmotionScore
                            : viewModel.weekEmotionScore,
                        isCurved: true,
                        barWidth: 2,
                        gradient: const LinearGradient(
                          colors: ChartComponent.gradientColors,
                        ),

                        // 점 설정
                        dotData: const FlDotData(
                          show: true,
                        ),

                        // 아래 그래프 설정
                        belowBarData: BarAreaData(
                          show: true,
                          gradient: LinearGradient(
                            colors: ChartComponent.gradientColors
                                .map((color) => color.withOpacity(0.1))
                                .toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  FlLine drawingHorizontalLine(double value) {
    return FlLine(
      color: value.toInt() % 25 != 0
          ? Colors.transparent
          : const Color(0x44757575),
      strokeWidth: 1,
      dashArray: [4],
    );
  }

  FlLine drawingVerticalLine(double value) {
    int term = period == TimePeriod.thirty ? 5 : 1;

    int currentPoint = period.value - value.toInt() + 1;

    return FlLine(
      color: currentPoint % term != 0
          ? Colors.transparent
          : const Color(0x44757575),
      strokeWidth: 1,
      dashArray: [4],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 12,
    );

    int term = period == TimePeriod.thirty ? 5 : 1;

    DateTime valueDate =
    DateTime.now().subtract(Duration(days: period.value - value.toInt()));

    int currentPoint = period.value - value.toInt() + 1;

    if (currentPoint % term != 0 || (period.value + 0.3 == value)) {
      return SideTitleWidget(
        axisSide: meta.axisSide,
        child: const SizedBox(),
      );
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(valueDate.day.toString(), style: style),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 12,
    );

    if (value.toInt() % 25 != 0) {
      return const SizedBox();
    }

    return Text(value.toInt().toString(),
        style: style, textAlign: TextAlign.right);
  }
}
