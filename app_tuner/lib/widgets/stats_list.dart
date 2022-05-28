

import 'package:app_tuner/models/tuner_stats.dart';
import 'package:app_tuner/widgets/stat_item.dart';
import 'package:flutter/cupertino.dart';

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
        );
      },
    );
  }
}