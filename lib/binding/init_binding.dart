import 'package:get/get.dart';
import 'package:tea_time/provider/Auth/auth_provider.dart';
import 'package:tea_time/provider/community/community_provider.dart';
import 'package:tea_time/provider/diary/diary_provider.dart';
import 'package:tea_time/provider/home/home_provider.dart';
import 'package:tea_time/provider/setting/user_info_provider.dart';
import 'package:tea_time/repository/community/community_diary_repository.dart';
import 'package:tea_time/repository/home/diary_calendar_repository.dart';
import 'package:tea_time/repository/home/diary_detail_repository.dart';
import 'package:tea_time/repository/home/home_repository.dart';
import 'package:tea_time/repository/setting/user_info_repository.dart';

class InitBinding extends Bindings {
  @override
  void dependencies() {
    // Provider
    Get.lazyPut<AuthProvider>(() => AuthProvider());
    Get.lazyPut<HomeProvider>(() => HomeProvider());
    Get.lazyPut<DiaryProvider>(() => DiaryProvider());
    Get.lazyPut<UserInfoProvider>(() => UserInfoProvider());
    Get.lazyPut<CommunityProvider>(() => CommunityProvider());

    // Repository
    Get.lazyPut<HomeRepository>(() => HomeRepository());
    Get.lazyPut<DiaryCalendarRepository>(() => DiaryCalendarRepository());
    Get.lazyPut<DiaryDetailRepository>(() => DiaryDetailRepository());
    Get.lazyPut<UserInfoRepository>(() => UserInfoRepository());
    Get.lazyPut<CommunityDiaryRepository>(() => CommunityDiaryRepository());
  }
}