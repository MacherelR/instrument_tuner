

import 'package:app_tuner/models/tuner_stats.dart';
import 'package:flutter/material.dart';

class StatItem extends StatelessWidget{
  const StatItem({
    Key? key,
    required this.stat
}) : super(key: key);
  final TunerStats stat;

  @override
  Widget build(BuildContext context){
    return ListTile(
      title: Text(stat.date.toString()),

    );
  }
}