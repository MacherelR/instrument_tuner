

import 'package:app_tuner/models/tuner_stats.dart';
import 'package:equatable/equatable.dart';
enum StatsOverviewStatus {initial, loading, loaded, fail}
class StatsState extends Equatable{
  const StatsState({
    this.status = StatsOverviewStatus.initial,
    this.stats = const [],
    this.editedStat
});

  final StatsOverviewStatus status;
  final List<TunerStats> stats;
  final TunerStats? editedStat;

  StatsState copyWith({
  StatsOverviewStatus? status,
    List<TunerStats>? stats,
    TunerStats? editedStat
}){
    return StatsState(
      status: status ?? this.status,
      stats: stats ?? this.stats,
      editedStat: editedStat ?? this.editedStat);
  }

  @override
  List<Object?> get props => [status,stats,editedStat];
}