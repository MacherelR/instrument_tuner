import 'package:app_tuner/Apis/SharedPrefsSettingsAPI.dart';
import 'package:app_tuner/repository/tuner_repository.dart';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Apis/hive_api.dart';
import 'app.dart';
import 'models/tuner_stats.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final hiveStorage = HiveApi();
  Hive.registerAdapter(TunerStatsAdapter());
  Hive.registerAdapter(DurationAdapter());
  final sharedPrefsStorage =
      SharedPrefsSettingsAPI(plugin: await SharedPreferences.getInstance());
  runApp(App(
      tunerRepository: TunerRepository(
      settingsApi: sharedPrefsStorage,
      statsApi: hiveStorage
  )));
}
