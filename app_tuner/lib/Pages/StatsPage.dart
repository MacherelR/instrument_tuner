import 'package:app_tuner/Stats/stats_bloc.dart';
import 'package:app_tuner/Stats/stats_event.dart';
import 'package:app_tuner/Stats/stats_state.dart';
import 'package:app_tuner/repository/tuner_repository.dart';
import 'package:app_tuner/widgets/stats_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Pages/HomePage.dart';
import '../traductions.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StatsBloc(
        tunerRepository: context.read<TunerRepository>(),
      )..add(const StatsSubscriptionRequested()),
      child: const StatsView(),
    );
  }
}

class StatsView extends StatelessWidget {
  const StatsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return BlocBuilder<StatsBloc, StatsState>(builder: (context, state) {
      if (state.status == StatsOverviewStatus.loading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state.status == StatsOverviewStatus.fail) {
        return Center(
          child: Text(LocalizationTraductions.of(context).title),
        );
      }

      if (state.stats.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.edit_off,
                size: height * 0.05,
              ),
              Text(
                LocalizationTraductions.of(context).noStats,
                style: TextStyle(fontSize: height * 0.03),
              )
            ],
          ),
        );
      }

      return StatsList(stats: state.stats);
    });
  }
}
