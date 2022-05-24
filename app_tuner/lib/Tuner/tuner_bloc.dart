import 'dart:async';
import 'dart:typed_data';

import 'package:app_tuner/Settings/settings_event.dart';
import 'package:app_tuner/Settings/settings_state.dart';
import 'package:app_tuner/Tuner/tuner_event.dart';
import 'package:app_tuner/Tuner/tuner_state.dart';
import 'package:app_tuner/models/Settings.dart';
import 'package:app_tuner/repository/settings_repository.dart';
import 'package:app_tuner/repository/tuner_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_audio_capture/flutter_audio_capture.dart';
import 'package:pitch_detector_dart/pitch_detector.dart';
import 'package:pitchupdart/pitch_handler.dart';

class TunerBloc extends Bloc<TunerEvent, TunerState>{
  TunerBloc({required TunerRepository tunerRepository})
  : _tunerRepository = tunerRepository,
  super(TunerState(status: TunerStatus.initial)){
    on<TunerSubscriptionRequested>(_onTunerSubscriptionRequested);
    on<TunerPermissionRequested>(_onTunerPermissionRequested);
    on<TunerStarted>(_onTunerStarted);
    on<TunerStopped>(_onTunerStopped);
    on<TunerRefresh>(_onTunerRefresh);
    //Add remaining events
  }

  final TunerRepository _tunerRepository;
  Stopwatch tuneTime = Stopwatch();
  Timer? _timer;
  PitchHandler?  pitchUp;
  FlutterAudioCapture _audioRecorder = FlutterAudioCapture();


  Future<void> _onTunerSubscriptionRequested(
      TunerSubscriptionRequested event, Emitter<TunerState> emit) async {
    emit(state.copyWith(status: TunerStatus.loading));
    TunerSettings _settings = await _tunerRepository.getSettings();

    emit(state.copyWith(status: TunerStatus.loaded, settings: _settings));
  }

  Future<void> _onTunerPermissionRequested(
      TunerPermissionRequested event, Emitter<TunerState> emit) async {
    if(state.permissions.isEnabled == false){
      state.permissions.RequestPermission();
      emit(state.copyWith(status: TunerStatus.permissionDenied));
      // Request logic
    }
    else{
      emit(state.copyWith(status: TunerStatus.running));
    }
  }

  Future<void> _onTunerStarted(
      TunerStarted event, Emitter<TunerState> emit) async {
    pitchUp = PitchHandler(state.settings.instrumentType);
    emit(state.copyWith(status: TunerStatus.running));
    tuneTime.reset();
    tuneTime.start();
    _timer = Timer.periodic(Duration(milliseconds: 60), _generateTrace);
    await _audioRecorder.start(listener, onError,
        sampleRate: 44100, bufferSize: 3000);
    state.note = "";
    state.status1 = "Please play a note";
  }

  _generateTrace(Timer t) {
    // Add to the growing dataset
    state.tracePitch.add(state.diffFrequency);
  }
  Future<void> _onTunerStopped(
      TunerStopped event, Emitter<TunerState> emit) async {

  }

  void listener(dynamic obj) { // Move to bloc private method
    var buffer = Float64List.fromList(obj.cast<double>());
    final List<double> sample = buffer.toList();
    // Compute result pitch value
    final result = state.pitchDetectorDart.getPitch(sample);


    if (result.pitched) {
      final handledPitch = pitchUp!.handlePitch(result.pitch);
      state.note = handledPitch.note;
      state.status1 = handledPitch.diffFrequency.toString();
      state.status2 = result.pitch;
      state.diffFrequency = handledPitch.diffFrequency;
      TunerRefresh();
    }
  }

  Future<void> _onTunerRefresh(TunerRefresh event, Emitter<TunerState> emit) async {

  }
  // Emit state for each thing

  // Add start/stop event -> Start emit status running


  // add permissions
}