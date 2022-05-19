import 'dart:async';

import 'package:app_tuner/Blocs/settings_event.dart';
import 'package:app_tuner/Blocs/settings_state.dart';
import 'package:app_tuner/Blocs/tuner_event.dart';
import 'package:app_tuner/Blocs/tuner_state.dart';
import 'package:app_tuner/models/Settings.dart';
import 'package:app_tuner/repository/settings_repository.dart';
import 'package:app_tuner/repository/tuner_repository.dart';
import 'package:bloc/bloc.dart';

class TunerBloc extends Bloc<TunerEvent, TunerState>{
  TunerBloc({required TunerRepository tunerRepository})
  : _tunerRepository = tunerRepository,
  super(TunerState(status: TunerStatus.initial)){
    on<TunerSubscriptionRequested>(_onTunerSubscriptionRequested);
  }

  final TunerRepository _tunerRepository;
  Future<void> _onTunerSubscriptionRequested(
      TunerSubscriptionRequested event, Emitter<TunerState> emit) async {
    emit(state.copyWith(status: TunerStatus.loading));
    TunerSettings _settings = await _tunerRepository.getSettings();
    emit(state.copyWith(status: TunerStatus.loaded, settings: _settings));
  }
}