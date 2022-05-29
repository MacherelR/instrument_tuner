import 'package:app_tuner/cubits/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Settings/SettingsPage.dart';
import '../Tuner/TunerPage.dart';
import '../Tuner/TunerPage_2.dart';

import 'dart:async';
import 'package:flutter/foundation.dart' show SynchronousFuture;

class LocalizationTraductions {
  LocalizationTraductions(this.locale);

  final Locale locale;

  static LocalizationTraductions of(BuildContext context) {
    return Localizations.of<LocalizationTraductions>(
        context, LocalizationTraductions)!;
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
      'noData': 'No data available',
      'statsDetails': 'Stats details',
      'deleteStat': 'Delete this stat',
      'tuningDate': 'Tuning date',
      'durationInMinutes': 'Duration in minutes : ',
      'durationInSeconds': 'Duration in seconds : ',
      'noLocationAvailable': 'No location available',
      'tunedIn': 'Tuned in : ',
      'permissionRefused': 'Permission refused',
      'microphonePermissionsRequired':
          'Microphone permissions are required to use the app',
      'askForPermissions':
          'Microphone permissions are disabled, would you like to allow them?',
      'instrumentType': 'Instrument type',
      'a4Frequency': 'Frequency for A4',
      'defineFrequency': 'Define frequency',
      'notANumber': 'Not a number',
      'zeroForbidden': 'Zero is forbidden',
      'duration': 'Duration',
      'date': 'Date',
      'dateDeleted': 'has been deleted',
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
      'noData': 'Pas de données disponibles',
      'statsDetails': 'Détails des statistiques',
      'deleteStat': 'Supprimer cette statistique',
      'tuningDate': 'Date d\'accordage',
      'durationInMinutes': 'Durée en minutes : ',
      'durationInSeconds': 'Durée en secondes : ',
      'noLocationAvailable': 'Pas de localisation disponible',
      'tunedIn': 'Accordé en : ',
      'permissionRefused': 'Permission refusée',
      'microphonePermissionsRequired':
          'Les permissions du microphone sont requises pour utiliser l\'application',
      'askForPermissions':
          'Les permissions du microphone sont désactivées, voulez-vous les activer ?',
      'instrumentType': 'Type d\'instrument',
      'a4Frequency': 'Fréquence de A4',
      'defineFrequency': 'Définir la fréquence',
      'notANumber': 'Nombre non valide',
      'zeroForbidden': 'Zéro interdit',
      'duration': 'Durée',
      'date': 'Date',
      'dateDeleted': 'a été supprimé',
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

  String get noData {
    return _localizedValues[locale.languageCode]!['noData']!;
  }

  String get statsDetails {
    return _localizedValues[locale.languageCode]!['statsDetails']!;
  }

  String get deleteStat {
    return _localizedValues[locale.languageCode]!['deleteStat']!;
  }

  String get tuningDate {
    return _localizedValues[locale.languageCode]!['tuningDate']!;
  }

  String get durationInMinutes {
    return _localizedValues[locale.languageCode]!['durationInMinutes']!;
  }

  String get durationInSeconds {
    return _localizedValues[locale.languageCode]!['durationInSeconds']!;
  }

  String get noLocationAvailable {
    return _localizedValues[locale.languageCode]!['noLocationAvailable']!;
  }

  String get tunedIn {
    return _localizedValues[locale.languageCode]!['tunedIn']!;
  }

  String get permissionRefused {
    return _localizedValues[locale.languageCode]!['permissionRefused']!;
  }

  String get microphonePermissionsRequired {
    return _localizedValues[locale.languageCode]![
        'microphonePermissionsRequired']!;
  }

  String get askForPermissions {
    return _localizedValues[locale.languageCode]!['askForPermissions']!;
  }

  String get instrumentType {
    return _localizedValues[locale.languageCode]!['instrumentType']!;
  }

  String get a4Frequency {
    return _localizedValues[locale.languageCode]!['a4Frequency']!;
  }

  String get defineFrequency {
    return _localizedValues[locale.languageCode]!['defineFrequency']!;
  }

  String get notANumber {
    return _localizedValues[locale.languageCode]!['notANumber']!;
  }

  String get zeroForbidden {
    return _localizedValues[locale.languageCode]!['zeroForbidden']!;
  }

  String get duration {
    return _localizedValues[locale.languageCode]!['duration']!;
  }

  String get date {
    return _localizedValues[locale.languageCode]!['date']!;
  }

  String get dateDeleted {
    return _localizedValues[locale.languageCode]!['dateDeleted']!;
  }
}

class DemoLocalizationsDelegate
    extends LocalizationsDelegate<LocalizationTraductions> {
  const DemoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      LocalizationTraductions.languages().contains(locale.languageCode);

  @override
  Future<LocalizationTraductions> load(Locale locale) {
    // Returning a SynchronousFuture here because an async "load" operation
    // isn't needed to produce an instance of DemoLocalizations.
    return SynchronousFuture<LocalizationTraductions>(
        LocalizationTraductions(locale));
  }

  @override
  bool shouldReload(DemoLocalizationsDelegate old) => false;
}
