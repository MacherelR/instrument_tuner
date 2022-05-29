import 'package:app_tuner/repository/tuner_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'Pages/HomePage.dart';

class App extends StatefulWidget {
  const App({Key? key, required this.tunerRepository}) : super(key: key);

  final TunerRepository tunerRepository;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: widget.tunerRepository,
      child: MaterialApp(
        onGenerateTitle: (context) => DemoLocalizations.of(context).title,
        localizationsDelegates: const [
          DemoLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''),
          Locale('fr', ''),
        ],
        routes: {HomePage.route: (context) => const HomePage()},
        initialRoute: HomePage.route,
      ),
    );
  }
}
