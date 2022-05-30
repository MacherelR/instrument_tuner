import 'dart:async';
import 'dart:typed_data';
import 'package:app_tuner/Tuner/tuner_display.dart';
import 'package:app_tuner/Tuner/tuner_event.dart';
import 'package:app_tuner/Tuner/tuner_state.dart';
import 'package:app_tuner/Settings/Settings.dart';
import 'package:app_tuner/repository/tuner_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:geopoint/geopoint.dart';
import 'package:latlng/latlng.dart' as lat;

import 'package:geolocator/geolocator.dart' as geo;
import '../traductions.dart';
import '../pitchDetector_lib/pitchup_dart/lib/pitch_handler.dart';

class TunerBloc extends Bloc<TunerEvent, TunerState> {
  TunerBloc({required TunerRepository tunerRepository})
      : _tunerRepository = tunerRepository,
        super(TunerState(status: TunerStatus.initial)) {
    on<TunerSubscriptionRequested>(_onTunerSubscriptionRequested);
    on<TunerPermissionRequested>(_onTunerPermissionRequested);
    on<TunerStarted>(_onTunerStarted);
    on<TunerStopped>(_onTunerStopped);
    on<TunerPitchRefreshed>(_onTunerPitchRefresh);
    on<TunerDisplayRefreshed>(_onTunerDisplayRefresh);
  }

  final TunerRepository _tunerRepository;
  Stopwatch tuneTime = Stopwatch();
  Timer? _timer;
  PitchHandler? pitchUp;

  Future<void> _onTunerSubscriptionRequested(
      TunerSubscriptionRequested event, Emitter<TunerState> emit) async {
    emit(state.copyWith(status: TunerStatus.loading));
    TunerSettings _settings = await _tunerRepository.getSettings();
    var loc = await _determinePosition();
    print(loc);
    TunerDisplay display = TunerDisplay.initial();
    emit(state.copyWith(
        status: TunerStatus.loaded,
        settings: _settings,
        displayedValues: display,localisation: loc));
  }

  Future<void> _onTunerPermissionRequested(
      TunerPermissionRequested event, Emitter<TunerState> emit) async {
    state.permissions.RequestPermission();
    if (state.permissions.isEnabled == true) {
      emit(state.copyWith(status: TunerStatus.permissionsEnabled));
    } else {
      TunerDisplay disp = TunerDisplay(
          Text(LocalizationTraductions.of(event.context).permissionRefused)
              .data,
          null,
          null,
          null,
          null);
      emit(state.copyWith(status: TunerStatus.permissionDenied,displayedValues: disp));
    }
  }

  Future<void> _onTunerStarted(
      TunerStarted event, Emitter<TunerState> emit) async {
    if (state.permissions.isEnabled == false) {
      add(TunerPermissionRequested(event.context));
      emit(state.copyWith(status: TunerStatus.permissionRequested));
    }
    pitchUp = PitchHandler(state.settings.instrumentType);
    emit(state.copyWith(status: TunerStatus.running,tracePitch: []));
    tuneTime.reset();
    tuneTime.start();
    _timer = Timer.periodic(const Duration(milliseconds: 60), _generateTrace);
    await state.audioCapture!
        .start(listener, onError, sampleRate: 44100, bufferSize: 3000);
    emit(state.copyWith(
        displayedValues: TunerDisplay(
            Text(LocalizationTraductions.of(event.context).title).data,
            null,
            "",
            null,
            null)));
  }

  _generateTrace(Timer t) {
    // Add to the growing dataset
    add(TunerPitchRefreshed([...state.tracePitch, state.displayedValues.newDif]));
  }

  Future<void> _onTunerStopped(
      TunerStopped event, Emitter<TunerState> emit) async {
    await state.audioCapture!.stop();
    tuneTime.stop();
    state.tunedTime = tuneTime.elapsed;
    if(_timer != null){
      _timer!.cancel();
      _timer = null;
    }
    TunerDisplay disp = TunerDisplay("", null, "", null, null);
    emit(state.copyWith(status: TunerStatus.stopped, displayedValues: disp));
  }

  void listener(dynamic obj) {
    var buffer = Float64List.fromList(obj.cast<double>());
    final List<double> sample = buffer.toList();
    // Compute result pitch value
    final result = state.pitchDetectorDart.getPitch(sample);

    if (result.pitched) {
      final handledPitch = pitchUp!.handlePitch(result.pitch);
      TunerDisplay disp = TunerDisplay(null, null, handledPitch.note,
          handledPitch.diffFrequency, handledPitch.diffFrequency.toString());
      add(TunerDisplayRefreshed(disp));
    }
  }

  Future<void> _onTunerPitchRefresh(
      TunerPitchRefreshed event, Emitter<TunerState> emit) async {
    emit(state.copyWith(status: TunerStatus.refresh, tracePitch: event.tracePitch,));
  }
  Future<void> _onTunerDisplayRefresh(
      TunerDisplayRefreshed event, Emitter<TunerState> emit) async {
    emit(state.copyWith(status: TunerStatus.refresh, displayedValues: event.tunerDisplay));
  }


  Future<geo.Position?> _determinePosition() async {
    bool serviceEnabled;
    geo.LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await geo.Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null; // Return null if location service is disabled
    }

    permission = await geo.Geolocator.checkPermission();
    if (permission == geo.LocationPermission.denied) {
      permission = await geo.Geolocator.requestPermission();
      if (permission == geo.LocationPermission.denied) {
        return null; // Return null if location service is disabled
      }
    }

    if (permission == geo.LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return null;
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await geo.Geolocator.getCurrentPosition();
  }
}
