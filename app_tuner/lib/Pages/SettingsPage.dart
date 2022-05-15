import 'package:app_tuner/Blocs/settings_event.dart';
import 'package:app_tuner/repository/settings_repository.dart';
import 'package:app_tuner/repository/tuner_repository.dart';
import 'package:app_tuner/widgets/freq_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pitchupdart/instrument_type.dart';

import '../Blocs/settings_bloc.dart';
import '../Blocs/settings_state.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsBloc(
        settingsRepository: context.read<TunerRepository>(),
      )..add(const SettingsSubscriptionRequested()),
      child: const SettingsView(),
    );
  }
}

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(builder: (context, state) {
      // if (state.status == SettingsStatus.loading) {
      //   return const Center(
      //     child: CircularProgressIndicator(),
      //   );
      // }

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Center(child: FrequencyForm()),
        ],
      );
    });
  }
}
