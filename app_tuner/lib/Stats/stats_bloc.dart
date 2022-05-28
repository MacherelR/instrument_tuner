

import 'package:app_tuner/Stats/stats_event.dart';
import 'package:app_tuner/Stats/stats_state.dart';
import 'package:app_tuner/models/tuner_stats.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/tuner_repository.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState>{
  StatsBloc({required TunerRepository tunerRepository})
    : _tunerRepository = tunerRepository,
      super(const StatsState()){
    on<StatsSubscriptionRequested>(_onSubscriptionRequested);
    on<StatsDeleted>(_onStatDeleted);
  }

  final TunerRepository _tunerRepository;

  Future<void> _onSubscriptionRequested(
      StatsSubscriptionRequested event, Emitter<StatsState>emit) async{
    emit(state.copyWith(status: StatsOverviewStatus.loading));
    await emit.forEach<List<TunerStats>>(_tunerRepository.getStats(),
        onData: (stats)=>
          state.copyWith(status: StatsOverviewStatus.loaded, stats: stats),
        onError: (_,__) {
          print(_);
          return state.copyWith(status: StatsOverviewStatus.fail);
    }
    );
  }

  Future<void> _onStatDeleted(
      StatsDeleted event, Emitter<StatsState>emit) async {
    await _tunerRepository.deleteStat(event.stat.id);
  }
}