import 'dart:convert';

import 'package:app_tuner/Apis/stats_api.dart';
import 'package:app_tuner/models/tuner_stats.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:rxdart/rxdart.dart';

class HiveApi extends StatsApi{
  final String _statsBox = "statsBox";
  late final Box<TunerStats> box;

  HiveApi(){
    _init();
  }

  void _init() async{
    await Hive.initFlutter();
    box = await Hive.openBox<TunerStats>(_statsBox);
    if(box.isNotEmpty){
      final stats = box.values.toList();
      _statsStreamController.add(stats);
    }
    else{
      //First time
      _statsStreamController.add(const[]);
    }
  }

  final _statsStreamController = BehaviorSubject<List<TunerStats>>();

  @override
  Future<void> deleteStat(String id) async{
    final stats = [..._statsStreamController.value];
    final statsIndex = stats.indexWhere((e) => e.id == id);
    if(statsIndex == -1){
      throw StatsNotFoundException();
    }
    else{
      await box.delete(id);
      stats.removeAt(statsIndex);
      _statsStreamController.add(stats);
    }
  }

  @override
  Stream<List<TunerStats>> getStats() => _statsStreamController.asBroadcastStream();

  @override
  Future<void> saveStat(TunerStats stat) async{
    final stats = [..._statsStreamController.value];
    final statIndex = stats.indexWhere((e) => e.id == stat.id);
    if(statIndex >= 0){
      stats[statIndex] = stat;
    }
    else{
      stats.add(stat);
    }
    await box.put(stat.id,stat);
    _statsStreamController.add(stats);
  }
}

