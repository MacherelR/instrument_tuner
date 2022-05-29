import 'package:app_tuner/Tuner/tuner_display.dart';
import 'package:app_tuner/models/MicrophonePermissions.dart';
import 'package:app_tuner/models/Settings.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_audio_capture/flutter_audio_capture.dart';
import 'package:pitch_detector_dart/pitch_detector.dart';

enum TunerStatus {
  initial,
  loading,
  loaded,
  error,
  running,
  stopped,
  permissionsEnabled,
  permissionDenied,
  refresh,
  permissionRequested
}

class TunerState extends Equatable {
  TunerState(
      {this.status = TunerStatus.initial,
      this.settings = const TunerSettings(),
      TunerDisplay? disp})
      : permissions = MicrophonePermissions(),
        displayedValues = disp ?? TunerDisplay.initial();
  final TunerStatus status;
  final TunerSettings settings;
  final MicrophonePermissions permissions;
  final audioRecorder = FlutterAudioCapture();
  final pitchDetectorDart = PitchDetector(44100, 2000);
  var diffFrequency = 0.0;
  List<double> tracePitch = [];
  var note = "";
  double status2 = 0;
  final TunerDisplay displayedValues;
  // Add note, diffFrequency, permissionsStatus, etc
  TunerState copyWith(
      {TunerStatus? status,
      TunerSettings? settings,
      TunerDisplay? displayedValues}) {
    return TunerState(
        status: status ?? this.status,
        settings: settings ?? this.settings,
        disp: displayedValues ?? this.displayedValues);
  }

  @override
  List<Object> get props => [status, settings];
}
