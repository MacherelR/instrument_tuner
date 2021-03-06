import 'package:app_tuner/models/tuner_stats.dart';
import 'package:equatable/equatable.dart';

abstract class StatsEvent extends Equatable{
  const StatsEvent();
  @override
  List<Object> get props => [];
}

class StatsSubscriptionRequested extends StatsEvent{
  const StatsSubscriptionRequested();
}

class StatsEdited extends StatsEvent{
  const StatsEdited(this.stats);
  final List<TunerStats> stats;

  @override
  List<Object> get props => [stats];
}

class StatsDeleted extends StatsEvent{
  const StatsDeleted(this.stat);

  final TunerStats stat;

  @override
  List<Object> get props => [stat];

}

class StatDetailLoad extends StatsEvent{
  const StatDetailLoad(this.statId);
  final String statId;

  @override
  List<Object> get props => [statId];
}