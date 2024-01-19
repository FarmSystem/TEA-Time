import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tea_time/util/function/log_on_dev.dart';
import 'package:tea_time/view/base/base_widget.dart';
import 'package:tea_time/view/diary/diary_read_screen.dart';
import 'package:tea_time/viewModel/home/diary_calendar_view_model.dart';

class DiaryCalendar extends BaseWidget<DiaryCalendarViewModel> {
  const DiaryCalendar({super.key});

  @override
  Widget buildView(BuildContext context) {
    return Obx(() {
      if (viewModel.isLoading.isTrue) {
        return const Center(child: CircularProgressIndicator());
      } else {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TableCalendar(
            locale: 'ko_KR',
            firstDay: DateTime.now().subtract(const Duration(days: 365 * 10 + 2)),
            lastDay: DateTime.now().add(const Duration(days: 365 * 10 + 2)),
            currentDay: DateTime.now(),
            focusedDay: viewModel.focusedDate,
            calendarFormat: viewModel.calendarFormat,
            daysOfWeekHeight: 30,
            rowHeight: 50,
            sixWeekMonthsEnforced: true,

            availableCalendarFormats: const {
              CalendarFormat.month: '한 달씩 보기',
            },

            calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, day, _) {
                  double? emotionScore = viewModel.diaries[DateFormat('yyyy-MM-dd').format(day)]?.emotionScore;

                  if (emotionScore == null) {
                    return Container(
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(255, 255, 255, 255),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '${day.day}',
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    );
                  }

                  Color backgroundColor;

                  if (emotionScore >= 80) {
                    backgroundColor = const Color.fromRGBO(174, 203, 244, 1);
                  } else if (emotionScore >= 50) {
                    backgroundColor = const Color.fromRGBO(252, 239, 166, 1);
                  } else {
                    backgroundColor = const Color.fromRGBO(223, 145, 142, 1);
                  }

                  return Container(
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '${day.day}',
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      )
                  );
                }
            ),

            calendarStyle: const CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
              ),
              selectedTextStyle: TextStyle(
                color: Colors.black,
              ),
              todayDecoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
              ),
              todayTextStyle: TextStyle(
                color: Colors.black,
              ),
            ),

            headerStyle: const HeaderStyle(
              titleCentered: true,
              formatButtonVisible: false,
              titleTextStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              leftChevronIcon: Icon(
                Icons.chevron_left,
                color: Colors.black,
              ),
              rightChevronIcon: Icon(
                Icons.chevron_right,
                color: Colors.black,
              ),
            ),

            selectedDayPredicate: (day) {
              bool isSelected = isSameDay(viewModel.selectedDate, day);
              double? emotionScore = viewModel.diaries[DateFormat('yyyy-MM-dd').format(day)]?.emotionScore;

              if (emotionScore != null || isSelected) {
                return false;
              } else {
                return true;
              }
            },

            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(viewModel.selectedDate, selectedDay)) {
                logOnDev(DateFormat('yyyy-MM-dd').format(selectedDay));
                viewModel.updateSelectedDate(selectedDay);
                final diaryId = viewModel.diaries[DateFormat('yyyy-MM-dd').format(selectedDay)]?.id;
                if (diaryId != null) {
                  Get.to(() => DiaryReadScreen(diaryId));
                }
              }
            },
          ),
        );
      }
    });
  }
}