import 'package:app_tuner/Settings/Settings.dart';

abstract class SettingsApi {
  Future<void> deleteSettings(String id);
  TunerSettings getSettings();
  Future<void> saveSettings(TunerSettings tunerSettings);
}
