

import 'package:app_tuner/Stats/stats_event.dart';
import 'package:app_tuner/Stats/stats_state.dart';
import 'package:app_tuner/models/tuner_stats.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';

import '../repository/tuner_repository.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState>{
  StatsBloc({required TunerRepository tunerRepository})
    : _tunerRepository = tunerRepository,
      super(StatsState()){
    on<StatsSubscriptionRequested>(_onSubscriptionRequested);
    on<StatsDeleted>(_onStatDeleted);
    on<StatDetailLoad>(_onStatDetailed);
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

  Future<void> _onStatDetailed(StatDetailLoad event, Emitter<StatsState>emit) async{
    emit(state.copyWith(status: StatsOverviewStatus.detailLoading));
    TunerStats stat = state.stats.where((s) => s.id == event.statId).first;
    await _getAddress(stat);
    emit(state.copyWith(status: StatsOverviewStatus.detailLoaded,detailedAddress: state.detailedAddress));
  }

  Future<void> _getAddress(TunerStats stat) async{
    if(stat.location != null){
      // Sometimes locator point crashes
      try{
        var addresses = await placemarkFromCoordinates(stat.location!.latitude, stat.location!.longitude);
        state.detailedAddress = addresses.first;
      }
      catch(e){
        state.detailedAddress = null;
      }

    }
    else{
      state.detailedAddress = null;
    }
  }
}