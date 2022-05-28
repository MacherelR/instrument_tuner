import 'package:app_tuner/Tuner/tuner_bloc.dart';
import 'package:app_tuner/Tuner/tuner_state.dart';
import 'package:app_tuner/repository/tuner_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oscilloscope/oscilloscope.dart';
import 'package:pitchupdart/pitch_handler.dart';

import '../Tuner/tuner_event.dart';
import '../models/tuner_stats.dart';

class TunerViewWidget extends StatefulWidget {
  const TunerViewWidget({Key? key}) : super(key: key);
  static const String route = '/home';
  @override
  State<TunerViewWidget> createState() => _TunerViewWidgetState();
}

class _TunerViewWidgetState extends State<TunerViewWidget> {
  @override
  void dispose() {
    // context.read<TunerBloc>().;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TunerBloc, TunerState>(builder: (context, state) {
      final pitchUp = PitchHandler(state.settings.instrumentType);
      // On click on start, call Bloc method
      // check if status == permissionDenied, _showDialog sinon rien
      Oscilloscope scopeOne = Oscilloscope(
        showYAxis: true,
        yAxisColor: Color.fromARGB(255, 255, 0, 0),
        margin: EdgeInsets.all(20.0),
        strokeWidth: 1.0,
        backgroundColor: Color.fromARGB(255, 0, 38, 255),
        traceColor: Colors.green,
        yAxisMax: 10.0,
        yAxisMin: -10.0,
        dataSet: state.tracePitch,
      );
      return Scaffold(
        body: Center(
          child: Column(
            children: [
              Center(
                child: Text(
                  state.note,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: FloatingActionButton(
                          heroTag: "Start",
                          onPressed: () {
                            context
                                .read<TunerBloc>()
                                .add(TunerStarted(context));
                          },
                          child: const Text("Start"),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: FloatingActionButton(
                          heroTag: "Stop",
                          onPressed: () {
                            context.read<TunerBloc>().add(TunerStopped());
                          },
                          child: const Text("Stop"),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: FloatingActionButton(
                          heroTag: "Save random stat",
                          onPressed: () {
                            Duration dur = const Duration(
                                hours: 1, minutes: 1, seconds: 2);
                            List<double> trace = [
                              -9,
                              -5,
                              2,
                              1,
                              -3,
                              3,
                              4,
                              0
                            ];
                            DateTime today = DateTime.now();
                            TunerStats rdm = TunerStats(
                                duration: dur, tracePitch: trace, date: today);
                            context.read<TunerRepository>().saveStat(rdm);
                            print("Stat saved");
                          },
                          child: const Text("Save rdm stat"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(flex: 1, child: scopeOne),
            ],
          ),
        ),
      );
      // return ElevatedButton(onPressed: (){
      //   context.read<TunerBloc>().add(TunerPermissionRequested());
      // }, child: const Text("Send request status"));
    });
  }
}
