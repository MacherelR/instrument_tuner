//
//
// import 'dart:async';
// import 'dart:math';
// import 'dart:typed_data';
//
// import 'package:app_tuner/Blocs/tuner_bloc.dart';
// import 'package:app_tuner/Blocs/tuner_state.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_audio_capture/flutter_audio_capture.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:pitch_detector_dart/pitch_detector.dart';
// import 'package:pitchupdart/pitch_handler.dart';
//
// import '../Blocs/settings_bloc.dart';
// import '../Blocs/settings_state.dart';
// import '../models/MicrophonePermissions.dart';
//
// class TunerViewWidget extends StatefulWidget {
//   const TunerViewWidget({Key? key}) : super(key: key);
//   static const String route = '/home';
//   @override
//   State<TunerViewWidget> createState() => _TunerViewWidgetState();
// }
//
// class _TunerViewWidgetState extends State<TunerViewWidget> {
//   final _audioRecorder = FlutterAudioCapture();
//   final pitchDetectorDart = PitchDetector(44100, 2000);
//   MicrophonePermissions permissions = MicrophonePermissions();
//   var note = "";
//   var status = "Click start";
//   double status2 = 0;
//   var status3 = "Click start";
//   List<double> tracePitch = [];
//   double radians = 0.0;
//   Timer? _timer;
//   _generateTrace(Timer t) {
//     // generate our  values
//     var sv = sin((radians * pi));
//
//     // Add to the growing dataset
//     setState(() {
//       tracePitch.add(status2);
//     });
//
//     // adjust to recyle the radian value ( as 0 = 2Pi RADS)
//     radians += 0.05;
//     if (radians >= 2.0) {
//       radians = 0.0;
//     }
//   }
//   @override
//   void dispose() {
//     _timer!.cancel();
//     super.dispose();
//   }
//   Future<void> _startRecording() async {
//     if (permissions.isEnabled) {
//       await _audioRecorder.start(listener, onError,
//           sampleRate: 44100, bufferSize: 3000);
//       setState(() {
//         note = "";
//         status = "Please play a note";
//       });
//     } else {
//       if (!permissions.hasBeenRefused) {
//         _showDialog();
//       } else {
//         status = "Microphone access denied";
//         note = "";
//       }
//     }
//   }
//   Future<void> _stopRecording() async {
//     await _audioRecorder.stop();
//     setState(() {
//       note = "";
//       status = "Stopped, please click on start button";
//
//     });
//   }
//   void _showDialog() {
//     showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: const Text("Microphone permissions disabled"),
//             content: const Text(
//                 "The microphones permissions are disabled, do you want to request them ?"),
//             actions: <Widget>[
//               TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: const Text("No")),
//               TextButton(
//                   onPressed: () async {
//                     await permissions.RequestPermission();
//                     Navigator.of(context).pop();
//                     await permissions.isGranted();
//                     if (permissions.isEnabled == false) {
//                       permissions.hasBeenRefused = true;
//                     } else {
//                       permissions.hasBeenRefused = false;
//                     }
//                     _startRecording();
//                   },
//                   child: const Text("Yes"))
//             ],
//           );
//         });
//   }
//   void listener(dynamic obj) {
//     var buffer = Float64List.fromList(obj.cast<double>());
//     final List<double> sample = buffer.toList();
//     // Compute result pitch value
//     final result = pitchDetectorDart.getPitch(sample);
//     /// Why not add directly to oscilloscope dataset here ?
//     if (result.pitched) {
//       final handledPitch = pitchUp.handlePitch(result.pitch);
//
//       setState(() {
//         note = handledPitch.note;
//         status = handledPitch.diffFrequency.toString();
//         status2 = result.pitch;
//         status3 = handledPitch.expectedFrequency.toString();
//       });
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<TunerBloc, TunerState>(builder: (context, state) {
//       final pitchUp = PitchHandler(state.settings.instrumentType);
//
//
//     });
//   }
// }