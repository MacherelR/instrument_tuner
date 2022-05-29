

import 'package:app_tuner/models/tuner_stats.dart';
import 'package:equatable/equatable.dart';
import 'package:geocoding/geocoding.dart';
enum StatsOverviewStatus {initial, loading, loaded, fail, detailLoading,detailLoaded}
class StatsState extends Equatable{
  StatsState({
    this.status = StatsOverviewStatus.initial,
    this.stats = const [],
    this.editedStat,
    this.detailedStat,
    this.detailedAddress
});

  final StatsOverviewStatus status;
  final List<TunerStats> stats;
  final TunerStats? editedStat;
  final TunerStats? detailedStat;
  Placemark? detailedAddress;
  StatsState copyWith({
  StatsOverviewStatus? status,
    List<TunerStats>? stats,
    TunerStats? editedStat,
    TunerStats? detailedStat,
    Placemark? detailedAddress,
}){
    return StatsState(
      status: status ?? this.status,
      stats: stats ?? this.stats,
      editedStat: editedStat ?? this.editedStat,
      detailedStat: detailedStat ?? this.detailedStat,
      detailedAddress : detailedAddress ?? this.detailedAddress);
  }

  @override
  List<Object?> get props => [status,stats,editedStat,detailedStat,detailedAddress];
}