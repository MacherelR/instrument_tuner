import 'package:app_tuner/models/MicrophonePermissions.dart';
import 'package:app_tuner/models/Settings.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_audio_capture/flutter_audio_capture.dart';
import 'package:pitch_detector_dart/pitch_detector.dart';

enum TunerStatus {initial, loading, loaded, error, running, stopped, permissionsEnabled, permissionDenied}

class TunerState extends Equatable{
  TunerState(
  {this.status = TunerStatus.initial,
  this.settings = const TunerSettings(),}) : permissions = MicrophonePermissions();
  final TunerStatus status;
  final TunerSettings settings;
  final MicrophonePermissions permissions;
  final _audioRecorder = FlutterAudioCapture();
  final pitchDetectorDart = PitchDetector(44100, 2000);
  var diffFrequency = 0.0;
  List<double> tracePitch = [];
  var note = "";
  var status1 = "Click start";
  double status2 = 0;
  var status3 = "Click start";
  // Add note, diffFrequency, permissionsStatus, etc
  TunerState copyWith({TunerStatus? status, TunerSettings? settings}){
    return TunerState(
      status: status ?? this.status, settings: settings ?? this.settings);
  }



  @override
  List<Object> get props => [status, settings];
}
