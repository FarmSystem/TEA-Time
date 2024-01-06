import 'package:flutter/material.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  // 이 예제에서는 2023년 5월을 기준으로 달력을 만듭니다.
  // 각 날짜에 할당할 색상을 정의합니다.
  final Map<int, Color> _markedDates = {
    1: Colors.green,
    15: Colors.red,
    20: Colors.blue,
  };

  // 주어진 월의 날짜 수를 계산합니다.
  int _getDaysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }

  // GridView를 만드는 메소드입니다.
  Widget _buildCalendarGridView(int year, int month) {
    final int daysInMonth = _getDaysInMonth(year, month);
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7, // 7 days in a week
        childAspectRatio: 1.0,
      ),
      itemCount: daysInMonth,
      itemBuilder: (context, index) {
        int day = index + 1;
        Color? color = _markedDates[day];
        return Container(
          margin: EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Center(
            child: Text(
              day.toString(),
              style: TextStyle(
                color: color != null ? Colors.white : Colors.black,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _buildCalendarGridView(2023, 5),
      ),
    );
  }
}
