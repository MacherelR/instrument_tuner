

import 'package:app_tuner/models/tuner_stats.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StatItem extends StatelessWidget{
  const StatItem({
    Key? key,
    required this.stat,
    required this.onTap,
}) : super(key: key);
  final TunerStats stat;
  final GestureTapCallback onTap;
  @override
  Widget build(BuildContext context){
    return ListTile(
      title: Text("Date : " + DateFormat('yyyy-MM-dd hh:mm').format(stat.date)),
      leading: const Icon(Icons.analytics_rounded),
      subtitle: Text(" Duration : " + stat.duration.toString()),
      onTap: onTap,
    );
  }
}