import 'package:app_tuner/models/Settings.dart';
import 'package:equatable/equatable.dart';

enum SettingsStatus { initial, loading, loaded, error }

class SettingsState extends Equatable {
  const SettingsState(
      {this.status = SettingsStatus.initial,
      this.settings = const TunerSettings()});
  final SettingsStatus status;
  final TunerSettings settings;

  SettingsState copyWith({SettingsStatus? status, TunerSettings? settings}) {
    return SettingsState(
        status: status ?? this.status, settings: settings ?? this.settings);
  }

  @override
  List<Object> get props => [status, settings];
}
