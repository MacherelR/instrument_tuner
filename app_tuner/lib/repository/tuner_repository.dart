import 'package:app_tuner/Apis/SettingsApi.dart';
import 'package:app_tuner/models/tuner_stats.dart';
import 'package:app_tuner/repository/settings_repository.dart';

import '../Apis/stats_api.dart';
import '../models/Settings.dart';

class TunerRepository {
  const TunerRepository({required SettingsApi settingsApi,required StatsApi statsApi})
      : _settingsApi = settingsApi, _statsApi = statsApi;

  final SettingsApi _settingsApi;

  final StatsApi _statsApi;

  Future<TunerSettings> getSettings() async {
    return await _settingsApi.getSettings();
  }

  Future<void> saveSettings(TunerSettings tunerSettings) async {
    return await _settingsApi.saveSettings(tunerSettings);
  }

  Future<void> deleteSettings(String id) async {
    return await _settingsApi.deleteSettings(id);
  }


  Future<void> saveStat(TunerStats stat) async {
    return await _statsApi.saveStat(stat);
  }

  Future<void> deleteStat(String id) async {
    return await _statsApi.deleteStat(id);
  }

  Stream<List<TunerStats>> getStats(){
    return _statsApi.getStats();
  }
}
