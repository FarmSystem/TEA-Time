import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tea_time/view/base/base_widget.dart';
import 'package:tea_time/view/diary/diary_read_screen.dart';
import 'package:tea_time/widget/home/emotion_calendar_item.dart';
import 'package:tea_time/viewModel/home/diary_calendar_view_model.dart';

class DiaryCalendar extends BaseWidget<DiaryCalendarViewModel> {
  const DiaryCalendar({super.key});

  @override
  Widget buildView(BuildContext context) {
    return Obx(() {
      if (viewModel.isLoading.isTrue) {
        return const Center(
          child: CircularProgressIndicator(),
        );
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
              outsideBuilder: (context, day, _) {
                return Opacity(
                  opacity: 0.5,
                  child: EmotionCalendarItem(
                    date: day,
                    diarySmallModel: viewModel.diaries?[DateFormat('yyyy-MM-dd').format(day)],
                  ),
                );
              },

              defaultBuilder: (context, day, _) {
                return EmotionCalendarItem(
                  date: day,
                  diarySmallModel: viewModel.diaries?[DateFormat('yyyy-MM-dd').format(day)],
                );
              },

              todayBuilder: (context, day, _) {
                return EmotionCalendarItem(
                  date: day,
                  diarySmallModel: viewModel.diaries?[DateFormat('yyyy-MM-dd').format(day)],
                );
              },

              selectedBuilder: (context, day, _) {
                return EmotionCalendarItem(
                  date: day,
                  diarySmallModel: viewModel.diaries?[DateFormat('yyyy-MM-dd').format(day)],
                );
              }
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
              return isSameDay(viewModel.selectedDate, day);
            },

            onDaySelected: (selectedDay, focusedDay) {
              viewModel.updateSelectedDate(selectedDay);
              final diaryId = viewModel.diaries?[DateFormat("yyyy-MM-dd").format(selectedDay)]?.id;
              if (diaryId != null) {
                Get.to(() => DiaryReadScreen(diaryId));
              }
            },
          ),
        );
      }
    });
  }
}
