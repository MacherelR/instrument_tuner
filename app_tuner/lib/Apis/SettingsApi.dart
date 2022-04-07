import 'package:app_tuner/models/Settings.dart';

abstract class SettingsApi {
  Future<void> deleteSettings(String id);
  Stream<TunerSettings> getSettings();
  Future<void> saveSettings(TunerSettings tunerSettings);
}

class TodoNotFoundException implements Exception {}
