import 'package:app_tuner/Tuner/tuner_display.dart';
import 'package:app_tuner/models/MicrophonePermissions.dart';
import 'package:app_tuner/models/Settings.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_audio_capture/flutter_audio_capture.dart';
import 'package:geopoint/geopoint.dart';

import '../pitchDetector_lib/pitch_detector_dart/lib/pitch_detector.dart';
import 'package:geolocator/geolocator.dart' as geo;
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
      TunerDisplay? disp,
      List<double>? tp,
      FlutterAudioCapture? audioRecorder,
      Duration? tTime,
      geo.Position? loc})
      : permissions = MicrophonePermissions(),
        displayedValues = disp ?? TunerDisplay.initial(),
        tracePitch = tp ?? [],
        audioCapture = audioRecorder ?? FlutterAudioCapture(),
        tunedTime = tTime ?? const Duration(hours: 0),
        localisation = loc;

  final TunerStatus status;
  final TunerSettings settings;
  final MicrophonePermissions permissions;
  final FlutterAudioCapture? audioCapture;
  final pitchDetectorDart = PitchDetector(44100, 2000);
  List<double> tracePitch;
  geo.Position? localisation;
  Duration? tunedTime;
  final TunerDisplay displayedValues;
  // Add note, diffFrequency, permissionsStatus, etc
  TunerState copyWith(
      {TunerStatus? status,
      TunerSettings? settings,
      FlutterAudioCapture? aCapture,
      TunerDisplay? displayedValues,
      List<double>? tracePitch,
      Duration? tunedTime,
      geo.Position? localisation}) {
    return TunerState(
        audioRecorder: aCapture ?? audioCapture,
        status: status ?? this.status,
        settings: settings ?? this.settings,
        disp: displayedValues ?? this.displayedValues,
        tp: tracePitch ?? this.tracePitch,
        tTime : tunedTime ?? this.tunedTime,
        loc: localisation ?? this.localisation);
  }

  @override
  List<Object?> get props => [status, settings, audioCapture, tracePitch, displayedValues, tunedTime,localisation];
}
