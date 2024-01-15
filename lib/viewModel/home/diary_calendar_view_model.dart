import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tea_time/model/diary/diary_calendar_info_model.dart';
import 'package:tea_time/model/diary/diary_small_model.dart';
import 'package:tea_time/repository/home/diary_calendar_repository.dart';

class DiaryCalendarViewModel extends GetxController {
  late final DiaryCalendarRepository _repository;

  late final Rx<CalendarFormat> _calendarFormat;
  late final Rxn<List<DiarySmallModel>> _diaries;

  late final Rx<DiaryCalendarInfoModel> _calendarInfo;
  DateTime get selectedDate => _calendarInfo.value.selectedDate;
  DateTime get focusedDate => _calendarInfo.value.focusedDate;

  List<DiarySmallModel>? get diaries => _diaries.value;
  CalendarFormat get calendarFormat => _calendarFormat.value;

  @override
  onInit() {
    super.onInit();
    // Dependency Injection
    _repository = Get.find<DiaryCalendarRepository>();

    // Initialize Fields
    _diaries = Rxn<List<DiarySmallModel>>(null);

    // Fetch Data
    initCalendarInfo();
    getDiaries();
  }

  void initCalendarInfo() {
    _calendarInfo = DiaryCalendarInfoModel.selectedDate(
      selectedDate: DateTime.now(),
    ).obs;
    _calendarFormat = CalendarFormat.month.obs;
  }

  void updateSelectedDate(DateTime date) {
    _calendarInfo.value = DiaryCalendarInfoModel.selectedDate(
      selectedDate: date,
    );
  }

  Future<void> getDiaries() async {
    try {
      _diaries.value = await _repository.getDiaries();
    } on Exception catch (_) {
      _diaries.value = null;
    }
  }
}