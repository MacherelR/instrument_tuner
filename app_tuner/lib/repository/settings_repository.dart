import 'package:app_tuner/Apis/SettingsApi.dart';

class SettingsRepository {
  const SettingsRepository({required SettingsApi settingsApi})
      : _settingsApi = settingsApi;
  final SettingsApi _settingsApi;
}
