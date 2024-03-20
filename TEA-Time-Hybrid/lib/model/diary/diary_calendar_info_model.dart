class DiaryCalendarInfoModel {
  DateTime selectedDate;
  DateTime focusedDate;

  DiaryCalendarInfoModel({
    required this.selectedDate,
    required this.focusedDate,
  });

  DiaryCalendarInfoModel.selectedDate({
    required this.selectedDate,
  }) : focusedDate = selectedDate;

  DiaryCalendarInfoModel copyWith({
    DateTime? selectedDate,
    DateTime? focusedDate,
  }) {
    return DiaryCalendarInfoModel(
      selectedDate: selectedDate ?? this.selectedDate,
      focusedDate: focusedDate ?? this.focusedDate,
    );
  }
}