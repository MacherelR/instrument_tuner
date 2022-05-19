

import 'package:app_tuner/models/tuner_stats.dart';

abstract class StatsApi{
  Future<void> deleteStat(String id);
  Stream<List<TunerStats>> getStats();
  Future<void> saveStat(TunerStats stat);
}


class StatsNotFoundException implements Exception {}
