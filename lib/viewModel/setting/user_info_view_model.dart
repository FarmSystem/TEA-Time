import 'package:get/get.dart';
import 'package:tea_time/model/setting/diary_token_model.dart';
import 'package:tea_time/model/setting/user_info_model.dart';
import 'package:tea_time/repository/setting/user_info_repository.dart';

class UserInfoViewModel extends GetxController {
  late final UserInfoRepository _userInfoRepository;
  late final Rxn<UserInfoModel> _userInfoModel;
  RxBool isLoading = false.obs;
  late final List<Rxn<DiaryTokenModel>> _diaryTokens;
  int currentPage = 1;
  bool isFetching = false;

  UserInfoModel? get userInfoModel => _userInfoModel.value;
  List<DiaryTokenModel> get diaryTokens =>
      _diaryTokens.map((e) => e.value!).toList();

  @override
  void onInit() {
    super.onInit();

    // Dependency Injection
    _userInfoRepository = Get.find<UserInfoRepository>();

    // Initialize
    _userInfoModel = Rxn<UserInfoModel>(null);
    _diaryTokens = List<Rxn<DiaryTokenModel>>.empty(growable: true);

    // Fetch data
    getUserInfo();
    getDiaryToken(0, 12);
  }

  Future<void> getUserInfo() async {
    try {
      _userInfoModel.value = await _userInfoRepository.getUserInfo();

      print(_userInfoModel.value!.toString());
    } on Exception catch (_) {
      _userInfoModel.value = null;
    }
  }

  Future<void> getDiaryToken(
      int page,
      int size
      ) async {
    if (isFetching) return;

    isFetching = true;

    try {
      isLoading.value = true;
      final tokens = await _userInfoRepository.getDiaryToken(page, size);
      if (tokens.isNotEmpty) {
        _diaryTokens.addAll(tokens.map((e) => Rxn<DiaryTokenModel>(e)).toList());
        page++;
      }
    } on Exception catch (_) {
      _diaryTokens.clear();
    } finally {
      isLoading.value = false;
      isFetching = false;
    }
  }
}