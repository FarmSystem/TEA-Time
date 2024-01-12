import 'package:tea_time/provider/setting/setting_provider.dart';

class SettingRepository {
  final SettingProvider _settingProvider;

  SettingRepository(this._settingProvider);

  Future<int> getUserLevel() async {
    final userLevel = await _settingProvider.getUserLevel();
    return userLevel.level;
  }

  Future<int> getUserScore() async {
    final userScore = await _settingProvider.getUserLevel();
    return userScore.score;
  }
}