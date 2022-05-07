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
  // runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPrefsStorage =
      SharedPrefsSettingsAPI(plugin: await SharedPreferences.getInstance());
  runApp(App(
      tunerRepository: TunerRepository(
    settingsRepository: SettingsRepository(settingsApi: sharedPrefsStorage),
  )));
}

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Instrument tuner',
//       initialRoute: '/home',
//       routes: {
//         // When navigating to the "/" route, build the FirstScreen widget.
//         '/home': (context) => const Tuner(title: 'Tuner'),
//         // When navigating to the "/stats" route, build the StatsScreen widget.
//         '/stats': (context) => const StatsScreen(),
//         // When navigating to the "/settings" route, build the SettingsScreen widget.
//         '/settings': (context) => const SettingsScreen(),
//       },
//       theme: ThemeData(
//         primarySwatch: Colors.grey,
//       ),
//       home: const Tuner(title: 'Instrument tuner app'),
//     );
//   }
// }
