import 'package:app_tuner/models/Settings.dart';
import 'package:equatable/equatable.dart';

enum TunerStatus {initial, loading, loaded, error}

class TunerState extends Equatable{
  const TunerState(
  {this.status = TunerStatus.initial,
  this.settings = const TunerSettings()});
  final TunerStatus status;
  final TunerSettings settings;
  TunerState copyWith({TunerStatus? status, TunerSettings? settings}){
    return TunerState(
      status: status ?? this.status, settings: settings ?? this.settings);
  }

  @override
  List<Object> get props => [status, settings];
}
