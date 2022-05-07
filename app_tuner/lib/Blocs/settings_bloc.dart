import 'dart:async';

import 'package:app_tuner/Blocs/settings_event.dart';
import 'package:app_tuner/Blocs/settings_state.dart';
import 'package:app_tuner/models/Settings.dart';
import 'package:app_tuner/repository/settings_repository.dart';
import 'package:bloc/bloc.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc({required SettingsRepository settingsRepository})
      : _settingsRepository = settingsRepository,
        super(SettingsState(status: SettingsStatus.initial)) {
    on<SettingsEdited>(_onSettingsEdited);
    on<SettingsSubscriptionRequested>(_onSettingsSubscriptionRequested);
  }

  final SettingsRepository _settingsRepository;

  // Future<void> _onSettingsEdited(
  //     SettingsEdited event, Emitter<SettingsState> emit) async {
  //   emit(state.copyWith(status: SettingsStatus.loading));
  //   TunerSettings settings = await _settingsRepository.getSettings();
  //   emit(SettingsState(status: SettingsStatus.loaded, settings: settings));
  // }
  Future<void> _onSettingsEdited(
      SettingsEdited event, Emitter<SettingsState> emit) async {
    await _settingsRepository.saveSettings(event.settings);
  }

  Future<void> _onSettingsSubscriptionRequested(
      SettingsSubscriptionRequested event, Emitter<SettingsState> emit) async {
    emit(state.copyWith(status: SettingsStatus.loading));
    TunerSettings settings = await _settingsRepository.getSettings();
    emit(state.copyWith(status: SettingsStatus.loaded, settings: settings));
  }
}
