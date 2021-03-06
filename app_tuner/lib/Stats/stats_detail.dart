import 'package:app_tuner/Stats/stats_bloc.dart';
import 'package:app_tuner/Stats/stats_event.dart';
import 'package:app_tuner/Stats/stats_state.dart';
import 'package:app_tuner/repository/tuner_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../traductions.dart';

class StatsDetail extends StatelessWidget {
  final String statId;
  final Function onDelete;

  const StatsDetail({
    Key? key,
    required this.statId,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          StatsBloc(tunerRepository: context.read<TunerRepository>())
            ..add(const StatsSubscriptionRequested()),
      child: DetailsView(id: statId, onDelete: onDelete),
    );
  }
}

class DetailsView extends StatelessWidget {
  DetailsView({
    Key? key,
    required this.id,
    required this.onDelete,
  }) : super(key: key);

  final String id;
  final Function onDelete;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatsBloc, StatsState>(
      buildWhen: (prev, next) {
        return prev.status != next.status ||
            prev.stats.length == next.stats.length;
      },
      builder: (context, state) {
        if (state.status != StatsOverviewStatus.detailLoaded) {
          context.read<StatsBloc>().add(StatDetailLoad(id));
        }

        if (state.stats.isEmpty) {
          return Center(
            child: Text(LocalizationTraductions.of(context).noData),
          );
        }
        if (state.status == StatsOverviewStatus.detailLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final stat = state.stats.where((s) => s.id == id).first;
        final List<_ChartData> data = [];
        for (var i = 0; i < stat.tracePitch.length; i++) {
          data.add(_ChartData(i, stat.tracePitch[i]));
        }
        charts.Series<_ChartData, int> chartD = charts.Series<_ChartData, int>(
          id: 'Tuner Data',
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          domainFn: (_ChartData data, _) => data.x,
          measureFn: (_ChartData data, _) => data.y,
          data: data,
        );
        final lineTrace = [chartD];

        return Scaffold(
          appBar: AppBar(
            title: Text(LocalizationTraductions.of(context).statsDetails),
            actions: [
              IconButton(
                tooltip:
                    Text(LocalizationTraductions.of(context).deleteStat).data,
                icon: const Icon(Icons.delete),
                onPressed: () {
                  onDelete();
                  Navigator.pop(context);
                },
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
                      child: Text(
                        LocalizationTraductions.of(context).tuningDate + " : " +
                            DateFormat('yyyy-MM-dd hh:mm').format(stat.date),
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                    stat.duration.inSeconds > 60
                        ? Text(LocalizationTraductions.of(context)
                                .durationInMinutes + " : " +
                            stat.duration.inMinutes.toString())
                        : Text(
                            LocalizationTraductions.of(context)
                                    .durationInSeconds + " : " +
                                stat.duration.inSeconds.toString(),
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                  ],
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: state.detailedAddress == null
                        ? [
                            Text(LocalizationTraductions.of(context)
                                .noLocationAvailable)
                          ]
                        : [
                            Text(LocalizationTraductions.of(context).tunedIn +
                                state.detailedAddress!.street!),
                            Text(state.detailedAddress!.postalCode!),
                            Text(state.detailedAddress!.locality!),
                          ]),
                Expanded(
                  child: charts.LineChart(lineTrace),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y);
  final int x;
  final double y;
}
