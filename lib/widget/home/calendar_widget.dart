import 'package:flutter/material.dart';
import 'package:tea_time/view/base/base_widget.dart';

class CalendarWidget extends BaseWidget {
  CalendarWidget({super.key});

  @override
  Widget buildView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: _buildCalendarGridView(2024, 1),
    );
  }

  final Map<int, Color> _markedDates = {
    1: Colors.green,
    15: Colors.red,
    20: Colors.blue,
  };

  int _getDaysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }

  Widget _buildCalendarGridView(int year, int month) {
    final int daysInMonth = _getDaysInMonth(year, month);
    return Container(
      height: 300,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7, // 7 days in a week
          childAspectRatio: 1.0,
        ),
        itemCount: daysInMonth,
        itemBuilder: (context, index) {
          int day = index + 1;
          Color? color = _markedDates[day];
          return Container(
            margin: const EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Center(
              child: Text(
                day.toString(),
              ),
            ),
          );
        },
      ),
    );
  }
}

