import 'package:equatable/equatable.dart';
import 'package:app_tuner/Settings/Settings.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();
  @override
  List<Object> get props => [];
}

class SettingsEdited extends SettingsEvent {
  const SettingsEdited(this.settings);
  final TunerSettings settings;

  @override
  List<Object> get props => [settings];
}

class SettingsSubscriptionRequested extends SettingsEvent {
  const SettingsSubscriptionRequested();
}
