import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_audio_capture/flutter_audio_capture.dart';
import 'package:pitch_detector_dart/pitch_detector.dart';
import 'package:pitchupdart/instrument_type.dart';
import 'package:pitchupdart/pitch_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _audioRecorder = FlutterAudioCapture();
  final pitchDetectorDart = PitchDetector(44100, 2000);
  // TODO : change instrumentType to the one selected
  final pitchUp = PitchHandler(InstrumentType.guitar);

  var note = "";
  var status = "Click start";
  Future<void> _startRecording() async {
    await _audioRecorder.start(listener, onError,
        sampleRate: 44100, bufferSize: 3000);
    setState(() {
      note = "";
      status = "Please play a note";
    });
  }

  Future<void> _stopRecording() async {
    await _audioRecorder.stop();
    setState(() {
      note = "";
      status = "Stopped, please click on start button";
    });
  }

  void listener(dynamic obj) {
    var buffer = Float64List.fromList(obj.cast<double>());
    final List<double> sample = buffer.toList();
    // Compute result pitch value
    final result = pitchDetectorDart.getPitch(sample);
    //print(result);
    if (result.pitched) {
      final handledPitch = pitchUp.handlePitch(result.pitch);

      setState(() {
        note = handledPitch.note;
        status = handledPitch.tuningStatus.toString();
      });
    }
  }

  void onError(Object err) {
    print(err);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
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
                          onPressed: _startRecording,
                          child: const Text("Start")))),
              Expanded(
                  child: Center(
                      child: FloatingActionButton(
                          onPressed: _stopRecording,
                          child: const Text("Stop")))),
            ],
          ))
        ]),
      ),
    );
  }
}
