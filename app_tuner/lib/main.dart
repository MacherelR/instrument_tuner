import 'package:app_tuner/Pages/SettingsPage.dart';
import 'package:app_tuner/Pages/StatsPage.dart';
import 'package:flutter/material.dart';
import 'Pages/TunerPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instrument tuner',
      initialRoute: '/home',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/home': (context) => const Tuner(title: 'Tuner'),
        // When navigating to the "/stats" route, build the StatsScreen widget.
        '/stats': (context) => const StatsScreen(),
        // When navigating to the "/settings" route, build the SettingsScreen widget.
        '/settings': (context) => const SettingsScreen(),
      },
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const Tuner(title: 'Instrument tuner app'),
    );
  }
}
