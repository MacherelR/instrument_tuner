import 'package:app_tuner/Tuner/tuner_display.dart';
import 'package:app_tuner/models/MicrophonePermissions.dart';
import 'package:app_tuner/models/Settings.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_audio_capture/flutter_audio_capture.dart';

import '../pitchDetector_lib/pitch_detector_dart/lib/pitch_detector.dart';

enum TunerStatus {initial, loading, loaded, error, running, stopped, permissionsEnabled, permissionDenied, refresh, permissionRequested}

class TunerState extends Equatable{
  TunerState(
      {this.status = TunerStatus.initial,
        this.settings = const TunerSettings(),TunerDisplay? disp, List<double>? tp}) : permissions = MicrophonePermissions(), displayedValues = disp ?? TunerDisplay.initial(), tracePitch = tp ?? [];
  final TunerStatus status;
  final TunerSettings settings;
  final MicrophonePermissions permissions;
  final audioRecorder = FlutterAudioCapture();
  final pitchDetectorDart = PitchDetector(44100, 2000);
  List<double> tracePitch;
  final TunerDisplay displayedValues;
  TunerState copyWith({TunerStatus? status, TunerSettings? settings, TunerDisplay? displayedValues, List<double>? tracePitch}){
    return TunerState(
        status: status ?? this.status, settings: settings ?? this.settings,
        disp : displayedValues ?? this.displayedValues,
        tp: tracePitch ?? this.tracePitch
    );
  }



  @override
  List<Object> get props => [status, settings, tracePitch, displayedValues];
}
