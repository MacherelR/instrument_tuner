import 'dart:typed_data';
import 'dart:async';
import 'dart:math';

import 'package:app_tuner/Settings/settings_event.dart';
import 'package:app_tuner/Tuner/tuner_bloc.dart';
import 'package:app_tuner/Tuner/tuner_event.dart';
import 'package:app_tuner/Tuner/tuner_state.dart';
import 'package:app_tuner/models/MicrophonePermissions.dart';
import 'package:app_tuner/models/Settings.dart';
import 'package:app_tuner/models/tunerChartData.dart';
import 'package:app_tuner/repository/settings_repository.dart';
import 'package:app_tuner/repository/tuner_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_capture/flutter_audio_capture.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pitch_detector_dart/pitch_detector.dart';
import 'package:pitchupdart/instrument_type.dart';
import 'package:pitchupdart/pitch_handler.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:oscilloscope/oscilloscope.dart';

import '../Settings/settings_bloc.dart';
import '../Settings/settings_state.dart';
import '../widgets/tunerView.dart';

class TunerScreen extends StatelessWidget{
  const TunerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return BlocProvider(
        create: (context) => TunerBloc(
          tunerRepository: context.read<TunerRepository>(),
        )..add(const TunerSubscriptionRequested()),
        child: const TunerView(),
    );
  }
}

class TunerView extends StatelessWidget{
  const TunerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context){

    return BlocBuilder<TunerBloc, TunerState>(builder: (context,state){
      Size size = MediaQuery.of(context).size;
      return SizedBox(
        height: size.height,
        width: size.width,
        child: TunerViewWidget(),
      );
    });
  }
}
