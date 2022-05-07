import 'dart:convert';
import 'package:app_tuner/Pages/TunerPage.dart';
import 'package:rxdart/rxdart.dart';
import 'package:app_tuner/Apis/SettingsApi.dart';
import 'package:app_tuner/models/Settings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_tuner/models/Settings.dart';

class SharedPrefsSettingsAPI extends SettingsApi {
  final _settingsKey = "settings_key";
  final SharedPreferences _preferences;

  SharedPrefsSettingsAPI({required SharedPreferences plugin})
      : _preferences = plugin {
    final settingsJson = _getValue(_settingsKey);
    if (settingsJson != null) {
      final settings = (json.decode(settingsJson) as List)
          .map((e) => TunerSettings.fromJson(e))
          .toList();
    } else {
      final settings = [const TunerSettings()];
    }
  }

  @override
  Future<void> deleteSettings(String id) {
    throw UnimplementedError();
  }

  final _settingsStreamController = BehaviorSubject<TunerSettings>();
  String? _getValue(String key) => _preferences.getString(_settingsKey);
  Future<void> _setValue(String key, String value) =>
      _preferences.setString(key, value);

  @override
  TunerSettings getSettings() {
    return _settingsStreamController.value;
  }

  @override
  Future<void> saveSettings(TunerSettings tunerSettings) {
    final settings = _settingsStreamController.value;
    _settingsStreamController.add(tunerSettings);
    return _setValue(_settingsKey, json.encode(settings));
  }
}
