import 'package:app_tuner/Apis/SharedPrefsSettingsAPI.dart';
import 'package:app_tuner/Pages/SettingsPage.dart';
import 'package:app_tuner/Pages/StatsPage.dart';
import 'package:app_tuner/repository/settings_repository.dart';
import 'package:app_tuner/repository/tuner_repository.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Pages/TunerPage.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPrefsStorage =
      SharedPrefsSettingsAPI(plugin: await SharedPreferences.getInstance());
  runApp(App(
      // Later there'll be settings repo and tuner repo in one
      tunerRepository: TunerRepository(
    settingsApi: sharedPrefsStorage,
  )));
}
