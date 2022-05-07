import 'package:app_tuner/repository/tuner_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Pages/HomePage.dart';
import 'Pages/TunerPage.dart';

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
        routes: {HomePage.route: (context) => const HomePage()},
        initialRoute: HomePage.route,
      ),
    );
  }
}
