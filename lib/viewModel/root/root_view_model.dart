import 'package:get/get.dart';

class RootViewModel extends GetxController {
  late final RxInt _selectedIndex;
  late final RxBool _isExpanded;

  int get selectedIndex => _selectedIndex.value;
  bool get isExpanded => _isExpanded.value;

  @override
  void onInit() {
    super.onInit();

    _selectedIndex = 0.obs;
    _isExpanded = false.obs;
  }

  void changeIndex(int index) {
    _selectedIndex.value = index;
  }

  void onClickFloatingActionButton() {
    _isExpanded.value = !_isExpanded.value;
  }
}
