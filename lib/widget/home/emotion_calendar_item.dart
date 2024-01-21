import 'package:flutter/material.dart';
import 'package:tea_time/model/diary/diary_small_model.dart';

class EmotionCalendarItem extends StatelessWidget {
  final DateTime date;
  final DiarySmallModel? diarySmallModel;

  const EmotionCalendarItem({super.key, required this.date, this.diarySmallModel});

  @override
  Widget build(BuildContext context) {
    if (diarySmallModel == null) {
      return Container(
        margin: const EdgeInsets.all(4),
        decoration: const BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 255),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            '${date.day}',
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      );
    }

    return Container(
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: _getBackgroundColor(),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            '${date.day}',
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        )
    );
  }

  Color _getBackgroundColor() {
    if (diarySmallModel!.emotionScore >= 80) {
      return const Color.fromRGBO(174, 203, 244, 1);
    } else if (diarySmallModel!.emotionScore >= 50) {
      return const Color.fromRGBO(252, 239, 166, 1);
    } else {
      return const Color.fromRGBO(223, 145, 142, 1);
    }
  }
}