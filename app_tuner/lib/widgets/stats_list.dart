

import 'package:app_tuner/Stats/stats_bloc.dart';
import 'package:app_tuner/Stats/stats_event.dart';
import 'package:app_tuner/models/tuner_stats.dart';
import 'package:app_tuner/widgets/stat_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Stats/stats_detail.dart';

class StatsList extends StatelessWidget{
  const StatsList({
    Key? key,
    required this.stats,
  }) : super(key: key);

  final List<TunerStats> stats;

  @override
  Widget build(BuildContext context){
    return ListView.builder(
      itemCount: stats.length,
      itemBuilder: (context,index){
        TunerStats stat = stats[index];
        return StatItem(stat: stat,
          onTap: ()=>
                Navigator.of(context).push(MaterialPageRoute(builder: (_){
                  return StatsDetail(
                    statId: stat.id,
                    onDelete: () => _removeStat(context, stat),
                  );
                })),
        );
      },
    );
  }

  void _removeStat(BuildContext context, TunerStats stat){
    context.read<StatsBloc>().add(StatsDeleted(stat));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.blue,
        duration: const Duration(seconds: 2),
        content: Text(
          "stat from ${stat.date} has been deleted ",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}