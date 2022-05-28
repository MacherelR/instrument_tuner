import 'package:app_tuner/cubits/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Settings/SettingsPage.dart';
import 'StatsPage.dart';
import '../Tuner/TunerPage.dart';
import '../Tuner/TunerPage_2.dart';

import 'dart:async';
import 'package:flutter/foundation.dart' show SynchronousFuture;
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class DemoLocalizations {
  DemoLocalizations(this.locale);

  final Locale locale;

  static DemoLocalizations of(BuildContext context) {
    return Localizations.of<DemoLocalizations>(context, DemoLocalizations)!;
  }

  static const _localizedValues = <String, Map<String, String>>{
    'en': {
      'title': 'Instrument Tuner',
      'stats': 'Stats',
      'settings': 'Settings',
      'test': 'AAAAAAAAAAAAAAAAAAAAA',
      'micPermissions': 'Permissions refused, please allow microphone access',
      'started': 'Started, please play a note',
      'stopped': 'Stopped, please click on start button',
      'noStats': 'No stats available',
    },
    'fr': {
      'title': 'Accordeur d\'instrument',
      'stats': 'Statistiques',
      'settings': 'Paramètres',
      'test': 'AAAAAAAAAAAAAAAAAAAAA',
      'micPermissions':
          'Permissions refusées, veuillez autoriser l\'accès au microphone',
      'started': 'Démarré, veuillez jouer une note',
      'stopped': 'Accordeur stoppé, cliquez sur le bouton démarrer',
      'noStats': 'Pas de statistiques disponibles',
    },
  };

  static List<String> languages() => _localizedValues.keys.toList();

  String get title {
    return _localizedValues[locale.languageCode]!['title']!;
  }

  String get stats {
    return _localizedValues[locale.languageCode]!['stats']!;
  }

  String get settings {
    return _localizedValues[locale.languageCode]!['settings']!;
  }

  String get test {
    return _localizedValues[locale.languageCode]!['test']!;
  }

  String get micPermissions {
    return _localizedValues[locale.languageCode]!['micPermissions']!;
  }

  String get started {
    return _localizedValues[locale.languageCode]!['started']!;
  }

  String get stopped {
    return _localizedValues[locale.languageCode]!['stopped']!;
  }

  String get noStats {
    return _localizedValues[locale.languageCode]!['noStats']!;
  }
}

class DemoLocalizationsDelegate
    extends LocalizationsDelegate<DemoLocalizations> {
  const DemoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      DemoLocalizations.languages().contains(locale.languageCode);

  @override
  Future<DemoLocalizations> load(Locale locale) {
    // Returning a SynchronousFuture here because an async "load" operation
    // isn't needed to produce an instance of DemoLocalizations.
    return SynchronousFuture<DemoLocalizations>(DemoLocalizations(locale));
  }

  @override
  bool shouldReload(DemoLocalizationsDelegate old) => false;
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String route = "/home";
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final selectedTab = context.select((HomeCubit cubit) => cubit.state.tab);
    return Scaffold(
      appBar: AppBar(
        title: Text(DemoLocalizations.of(context).title),
      ),
      body: selectedTab == HomeTab.tuner
          ? const Tuner()
          : selectedTab == HomeTab.stats
              ? const StatsScreen()
              : const SettingsScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: HomeTab.values.indexOf(selectedTab),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.tune), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.insert_chart), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
        ],
        onTap: (index) {
          context.read<HomeCubit>().setTab(HomeTab.values[index]);
        },
      ),
    );
  }
}
