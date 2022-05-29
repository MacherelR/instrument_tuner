import 'package:app_tuner/models/tuner_stats.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../traductions.dart';

class StatItem extends StatelessWidget {
  const StatItem({
    Key? key,
    required this.stat,
    required this.onTap,
  }) : super(key: key);
  final TunerStats stat;
  final GestureTapCallback onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(LocalizationTraductions.of(context).date +
          DateFormat('yyyy-MM-dd hh:mm').format(stat.date)),
      leading: const Icon(Icons.analytics_rounded),
      subtitle: Text(LocalizationTraductions.of(context).duration +
          stat.duration.toString()),
      onTap: onTap,
    );
  }
}
