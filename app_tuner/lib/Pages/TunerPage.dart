import 'dart:typed_data';
import 'dart:async';
import 'dart:math';

import 'package:app_tuner/models/MicrophonePermissions.dart';
import 'package:app_tuner/models/Settings.dart';
import 'package:app_tuner/models/tunerChartData.dart';
import 'package:app_tuner/repository/settings_repository.dart';
import 'package:app_tuner/repository/tuner_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_capture/flutter_audio_capture.dart';
import 'package:pitch_detector_dart/pitch_detector.dart';
import 'package:pitchupdart/instrument_type.dart';
import 'package:pitchupdart/pitch_handler.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:oscilloscope/oscilloscope.dart';

class Tuner extends StatefulWidget {
  const Tuner({Key? key}) : super(key: key);
  //MicrophonePermissions microphonePermissions;
  static const String route = '/home';
  @override
  State<Tuner> createState() => _TunerState();
}

//TODO : Transform this into TunerView (as in SettingsView), so that we can transmit the TunerRepository and link with the provider
class _TunerState extends State<Tuner> {
  final _audioRecorder = FlutterAudioCapture();
  final pitchDetectorDart = PitchDetector(44100, 2000);
  // TODO : change instrumentType to the one selected

  final pitchUp = PitchHandler(InstrumentType.guitar);
  MicrophonePermissions permissions = MicrophonePermissions();

  // SettingsRepository appsSettings;
  var note = "";
  var status = "Click start";
  double status2 = 0;
  var status3 = "Click start";
  var diffFrequency = 0.0;
  List<double> tracePitch = [];
  double radians = 0.0;
  Timer? _timer;
  Stopwatch tuneTime = Stopwatch();
  _generateTrace(Timer t) {
    // Add to the growing dataset
    setState(() {
      tracePitch.add(diffFrequency);
    });
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  Future<void> _startRecording() async {
    if (permissions.isEnabled) {
      tuneTime.reset();
      tuneTime.start();
      _timer = Timer.periodic(Duration(milliseconds: 60), _generateTrace);
      await _audioRecorder.start(listener, onError,
          sampleRate: 44100, bufferSize: 3000);
      setState(() {
        note = "";
        status = "Please play a note";
      });
    } else {
      if (!permissions.hasBeenRefused) {
        _showDialog();
      } else {
        status = "Microphone access denied";
        note = "";
      }
    }
  }

  Future<void> _stopRecording() async {
    await _audioRecorder.stop();
    tuneTime.stop();
    print(tuneTime.elapsed);
    _timer!.cancel();
    setState(() {
      note = "";
      status = "Stopped, please click on start button";
    });
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Microphone permissions disabled"),
            content: const Text(
                "The microphones permissions are disabled, do you want to request them ?"),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("No")),
              TextButton(
                  onPressed: () async {
                    await permissions.RequestPermission();
                    Navigator.of(context).pop();
                    await permissions.isGranted();
                    if (permissions.isEnabled == false) {
                      permissions.hasBeenRefused = true;
                    } else {
                      permissions.hasBeenRefused = false;
                    }
                    _startRecording();
                  },
                  child: const Text("Yes"))
            ],
          );
        });
  }

  void listener(dynamic obj) {
    var buffer = Float64List.fromList(obj.cast<double>());
    final List<double> sample = buffer.toList();
    // Compute result pitch value
    final result = pitchDetectorDart.getPitch(sample);

    /// Why not add directly to oscilloscope dataset here ?
    if (result.pitched) {
      final handledPitch = pitchUp.handlePitch(result.pitch);
      setState(() {
        note = handledPitch.note;
        status = handledPitch.diffFrequency.toString();
        status2 = result.pitch;
        diffFrequency = handledPitch.diffFrequency;
      });
    }
  }

  void onError(Object err) {
    print(err);
  }

  // List<TunerChartData>? tunerChartData;
  @override
  void initState() {
    super.initState();

    // tunerChartData = <TunerChartData>[];
  }

  @override
  Widget build(BuildContext context) {
    // Create A Scope Display for notes
    Oscilloscope scopeOne = Oscilloscope(
      showYAxis: true,
      yAxisColor: Colors.orange,
      margin: EdgeInsets.all(20.0),
      strokeWidth: 1.0,
      backgroundColor: Colors.black,
      traceColor: Colors.green,
      yAxisMax: 10.0,
      yAxisMin: -10.0,
      dataSet: tracePitch,
    );
    return Scaffold(
      body: Center(
        child: Column(children: [
          Center(
              child: Text(
            note,
            style: const TextStyle(
                color: Colors.black87,
                fontSize: 25.0,
                fontWeight: FontWeight.bold),
          )),
          const Spacer(),
          Center(
              child: Text(
            status,
            style: const TextStyle(
                color: Colors.black87,
                fontSize: 14.0,
                fontWeight: FontWeight.bold),
          )),
          Center(
              child: Text(
            status3,
            style: const TextStyle(
                color: Colors.black87,
                fontSize: 14.0,
                fontWeight: FontWeight.bold),
          )),
          Expanded(
            child: Row(
              children: [
                Expanded(
                    child: Center(
                        child: FloatingActionButton(
                            heroTag: "start",
                            onPressed: _startRecording,
                            child: const Text("Start")))),
                Expanded(
                    child: Center(
                        child: FloatingActionButton(
                            heroTag: "stop",
                            onPressed: _stopRecording,
                            child: const Text("Stop")))),
              ],
            ),
          ),
          Expanded(flex: 1, child: scopeOne),
        ]),
      ),
    );
  }
}
