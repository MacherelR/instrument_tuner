import 'package:app_tuner/Apis/SettingsApi.dart';
import 'package:app_tuner/models/Settings.dart';

class SettingsRepository {
  // With storage PART
  const SettingsRepository({required SettingsApi settingsApi})
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

  // final TunerSettings _settings = TunerSettings();
  // TunerSettings get settings => _settings;
}
