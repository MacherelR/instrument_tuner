import 'package:app_tuner/Apis/SettingsApi.dart';
import 'package:app_tuner/repository/settings_repository.dart';

import '../models/Settings.dart';

class TunerRepository {
  const TunerRepository({required SettingsApi settingsApi})
      : _settingsApi = settingsApi;

  final SettingsApi _settingsApi;

  Future<TunerSettings> getSettings() async {
    return await _settingsApi.getSettings();
  }

  Future<void> saveSettings(TunerSettings tunerSettings) async {
    return await _settingsApi.saveSettings(tunerSettings);
  }

  Future<void> deleteSettings(String id) async {
    return await _settingsApi.deleteSettings(id);
  }


  // TODO : Add required methods to store stats
}
