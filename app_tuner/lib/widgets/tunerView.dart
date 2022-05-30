import 'package:app_tuner/Tuner/tuner_bloc.dart';
import 'package:app_tuner/Tuner/tuner_state.dart';
import 'package:app_tuner/repository/tuner_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oscilloscope/oscilloscope.dart';

import '../Tuner/tuner_event.dart';
import '../models/tuner_stats.dart';
import '../pitchDetector_lib/pitchup_dart/lib/pitch_handler.dart';

class TunerViewWidget extends StatefulWidget {
  const TunerViewWidget({Key? key}) : super(key: key);
  static const String route = '/home';
  @override
  State<TunerViewWidget> createState() => _TunerViewWidgetState();
}

class _TunerViewWidgetState extends State<TunerViewWidget> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TunerBloc, TunerState>(builder: (context, state) {
      // print(state);
      //print(state.tracePitch);
      Oscilloscope scopeOne = Oscilloscope(
        showYAxis: true,
        yAxisColor: Colors.orange,
        margin: EdgeInsets.all(20.0),
        strokeWidth: 1.0,
        backgroundColor: Colors.black,
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
                  state.displayedValues.note,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),

                ),
              ),
              Center(
                child: Text(
                  state.displayedValues.newDif.toString(),
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
                    // Expanded(
                    //   child: Center(
                    //     child: FloatingActionButton(
                    //       heroTag: "Save random stat",
                    //       onPressed: () {
                    //         Duration dur = const Duration(
                    //             hours: 1, minutes: 1, seconds: 2);
                    //         List<double> trace = [
                    //           -9,
                    //           -5,
                    //           2,
                    //           1,
                    //           -3,
                    //           3,
                    //           4,
                    //           0
                    //         ];
                    //         DateTime today = DateTime.now();
                    //         TunerStats rdm = TunerStats(
                    //             duration: dur, tracePitch: trace, date: today);
                    //         context.read<TunerRepository>().saveStat(rdm);
                    //       },
                    //       child: const Text("Save rdm stat"),
                    //     ),
                    //   ),
                    // ),
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
