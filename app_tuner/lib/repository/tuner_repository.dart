import 'package:app_tuner/repository/settings_repository.dart';

import '../models/Settings.dart';

class TunerRepository {
  const TunerRepository({required SettingsRepository settingsRepository})
      : _settingsRepository = settingsRepository;

  final SettingsRepository _settingsRepository;

  Future<TunerSettings> getSettings() async {
    return await _settingsRepository.getSettings();
  }

  Future<void> saveSettings(TunerSettings tunerSettings) async {
    return await _settingsRepository.saveSettings(tunerSettings);
  }

  Future<void> deleteSettings(String id) async {
    return await _settingsRepository.deleteSettings(id);
  }

  // TODO : Add required methods to store stats
}
