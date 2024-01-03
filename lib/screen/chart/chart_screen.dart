import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tea_time/bloc/chart/chart_bloc.dart';
import 'package:fl_chart/fl_chart.dart';

import '../base/default_appbar.dart';

class ChartScreen extends StatelessWidget {
  const ChartScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChartBloc(),
      child: const _ChartScreenContent(),
    );
  }
}

class _ChartScreenContent extends StatelessWidget {
  const _ChartScreenContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: DefaultAppBar(
          title: 'Emotion Chart',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 그래프
            Expanded(
              child: BlocBuilder<ChartBloc, ChartState>(
                builder: (context, state) {
                  // 여기에서 주/월 단위에 따라 그래프를 그리도록 로직을 추가하세요.
                  // state로부터 주/월 단위에 따른 데이터를 가져와서 활용합니다.
                  // 예를 들어, LineChart, BarChart 등을 사용하여 그래프를 그릴 수 있습니다.

                  List<FlSpot> spots = [
                    FlSpot(0, 50),
                    FlSpot(1, 70),
                    FlSpot(2, 40),
                    FlSpot(3, 20),
                    FlSpot(4, 60),
                    FlSpot(5, 70),
                    FlSpot(6, 90),
                    FlSpot(7, 50),
                  ];

                  return LineChart(
                    LineChartData(
                      gridData: FlGridData(show: false),
                      titlesData: FlTitlesData(show: false),
                      borderData: FlBorderData(
                        show: true,
                        border: Border.all(
                            color: const Color(0xff37434d), width: 1),
                      ),
                      minX: 0,
                      maxX: 31, // 데이터의 갯수에 따라 조절
                      minY: 0,
                      maxY: 100, // 점수 범위에 따라 조절
                      lineBarsData: [
                        LineChartBarData(
                          spots: spots,
                          isCurved: true,
                          colors: [Colors.blue],
                          dotData: FlDotData(show: false),
                          belowBarData: BarAreaData(show: false),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // 주/월 선택 버튼
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<ChartBloc>(context)
                        .add(SelectWeeklyChartEvent());
                  },
                  child: Text("주 단위"),
                ),
                ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<ChartBloc>(context)
                        .add(SelectMonthlyChartEvent());
                  },
                  child: Text("월 단위"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
