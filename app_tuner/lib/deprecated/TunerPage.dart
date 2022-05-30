import 'dart:typed_data';
import 'dart:async';
import 'package:app_tuner/models/MicrophonePermissions.dart';
import 'package:app_tuner/Settings/Settings.dart';
import 'package:app_tuner/models/tuner_stats.dart';
import 'package:app_tuner/repository/tuner_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_capture/flutter_audio_capture.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:geopoint/geopoint.dart';
import 'package:oscilloscope/oscilloscope.dart';
import '../Pages/HomePage.dart';
import 'package:latlong2/latlong.dart';
import '../traductions.dart';

import '../pitchDetector_lib/pitch_detector_dart/lib/pitch_detector.dart';
import '../pitchDetector_lib/pitchup_dart/lib/pitch_handler.dart';

class Tuner extends StatefulWidget {
  const Tuner({Key? key}) : super(key: key);
  static const String route = '/home';
  @override
  State<Tuner> createState() => _TunerState();
}

enum TunerState { initial, running, stopped }

class _TunerState extends State<Tuner> {
  final _audioRecorder = FlutterAudioCapture();
  final pitchDetectorDart = PitchDetector(44100, 2000);

  late final PitchHandler pitchUp;
  MicrophonePermissions permissions = MicrophonePermissions();
  TunerState _tunerState = TunerState.initial;
  var note = "";
  var status = "Click start";
  double status2 = 0;
  var diffFrequency = 0.0;
  List<double> tracePitch = [];
  double radians = 0.0;
  Timer? _timer;
  Stopwatch tuneTime = Stopwatch();
  geo.Position? localisation;
  GeoPoint? location;
  _generateTrace(Timer t) {
    // Add to the growing dataset
    setState(() {
      tracePitch.add(diffFrequency);
    });
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer!.cancel();
    }
    super.dispose();
  }

  Future<void> _startRecording(BuildContext context) async {
    _tunerState = TunerState.running;
    if (permissions.isEnabled) {
      tuneTime.reset();
      tuneTime.start();
      _timer = Timer.periodic(Duration(milliseconds: 60), _generateTrace);
      await _audioRecorder.start(listener, onError,
          sampleRate: 44100, bufferSize: 3000);
      setState(() {
        note = "";
        status = Text(LocalizationTraductions.of(context).started).data!;
      });
    } else {
      if (!permissions.hasBeenRefused) {
        _showDialog();
      } else {
        status = Text(LocalizationTraductions.of(context).micPermissions).data!;
        note = "";
      }
    }
  }

  Future<void> _stopRecording() async {
    _tunerState = TunerState.stopped;
    await _audioRecorder.stop();
    tuneTime.stop();
    _timer!.cancel();
    setState(() {
      note = "";
      status = Text(LocalizationTraductions.of(context).stopped).data!;
    });
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(LocalizationTraductions.of(context)
                .microphonePermissionsRequired),
            content:
                Text(LocalizationTraductions.of(context).askForPermissions),
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
                    _startRecording(
                        context); // context.read<TunerBloc>().start()
                  },
                  child: const Text("Yes"))
            ],
          );
        });
  }

  void listener(dynamic obj) {
    // Move to bloc private method
    var buffer = Float64List.fromList(obj.cast<double>());
    final List<double> sample = buffer.toList();
    // Compute result pitch value
    final result = pitchDetectorDart.getPitch(sample);

    if (result.pitched) {
      final handledPitch = pitchUp.handlePitch(result.pitch);
      setState(() {
        note = handledPitch.note;
        status = handledPitch.diffFrequency.toString();
        status2 = result.pitch;
        diffFrequency = -handledPitch.diffFrequency;
      });
      //context.read<TunerBloc>().add(TunerRefresh())
    }
  }

  void onError(Object err) {
    print(err);
  }

  // List<TunerChartData>? tunerChartData;
  @override
  void initState() {
    super.initState();
    _getInstrumentType();
    _getLocalisation();
  }

  void _getInstrumentType() async {
    final TunerSettings settings =
        await context.read<TunerRepository>().getSettings();
    pitchUp = PitchHandler(settings.instrumentType);
  }

  void _getLocalisation() async {
    localisation = await _determinePosition();
    if (localisation != null) {
      LatLng point = LatLng(localisation!.latitude, localisation!.longitude);
      location = GeoPoint.fromLatLng(point: point);
    }
  }

  Future<geo.Position?> _determinePosition() async {
    bool serviceEnabled;
    geo.LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await geo.Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null; // Return null if location service is disabled
    }

    permission = await geo.Geolocator.checkPermission();
    if (permission == geo.LocationPermission.denied) {
      permission = await geo.Geolocator.requestPermission();
      if (permission == geo.LocationPermission.denied) {
        return null; // Return null if location service is disabled
      }
    }

    if (permission == geo.LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return null;
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await geo.Geolocator.getCurrentPosition();
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
          Expanded(
            child: Row(
              children: [
                Expanded(
                    child: Center(
                        child: FloatingActionButton(
                            heroTag: "start",
                            onPressed: () => {_startRecording(context)},
                            child: const Text("Start")))),
                Expanded(
                  child: Center(
                    child: Visibility(
                        visible: (_tunerState == TunerState.stopped),
                        maintainAnimation: true,
                        maintainState: true,
                        child: FloatingActionButton(
                          heroTag: "Save stat",
                          onPressed: () {
                            Duration dur = tuneTime.elapsed;
                            List<double> trace = tracePitch;
                            DateTime now = DateTime.now();
                            TunerStats stats = TunerStats(
                                duration: dur,
                                tracePitch: trace,
                                date: now,
                                latitude: location != null ? location!.latitude : null,
                                longitude: location != null ? location!.longitude : null);

                            context.read<TunerRepository>().saveStat(stats);
                          },
                          child: const Text("Save"),
                        )),
                  ),
                ),
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
