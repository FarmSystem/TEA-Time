import 'package:flutter_bloc/flutter_bloc.dart';

// 이벤트 정의
abstract class ChartEvent {}

class SelectWeeklyChartEvent extends ChartEvent {}

class SelectMonthlyChartEvent extends ChartEvent {}

// 상태 정의
abstract class ChartState {}

class WeeklyChartState extends ChartState {
  // 주 단위 차트 상태
}

class MonthlyChartState extends ChartState {
  // 월 단위 차트 상태
}

// BLoC 정의
class ChartBloc extends Bloc<ChartEvent, ChartState> {
  ChartBloc() : super(WeeklyChartState());

  @override
  Stream<ChartState> mapEventToState(ChartEvent event) async* {
    if (event is SelectWeeklyChartEvent) {
      yield WeeklyChartState();
    } else if (event is SelectMonthlyChartEvent) {
      yield MonthlyChartState();
    }
  }
}
