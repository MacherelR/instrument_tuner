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
      final settings = (json.decode(settingsJson));
    } else {
      final settings = const TunerSettings();
    }
  }

  @override
  Future<void> deleteSettings(String id) {
    throw UnimplementedError();
  }
  String? _getValue(String key) => _preferences.getString(_settingsKey);
  Future<void> _setValue(String key, String value) =>
      _preferences.setString(key, value);

  @override
  TunerSettings getSettings() {
    final settingsJson = _getValue(_settingsKey);
    if(settingsJson != null){
      var decoded = json.decode(settingsJson) as Map<String,dynamic>;
      var decodedSettings = TunerSettings.fromJson(decoded);
      return decodedSettings;
    }
    else{
      return const TunerSettings();
    }
  }

  @override
  Future<void> saveSettings(TunerSettings tunerSettings) {
    return _setValue(_settingsKey, json.encode(tunerSettings));
  }
}
