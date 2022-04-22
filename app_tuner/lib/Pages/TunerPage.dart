import 'dart:typed_data';

import 'package:app_tuner/models/MicrophonePermissions.dart';
import 'package:app_tuner/models/tunerChartData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_capture/flutter_audio_capture.dart';
import 'package:pitch_detector_dart/pitch_detector.dart';
import 'package:pitchupdart/instrument_type.dart';
import 'package:pitchupdart/pitch_handler.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:oscilloscope/oscilloscope.dart';

class Tuner extends StatefulWidget {
  const Tuner({Key? key, required this.title}) : super(key: key);
  //MicrophonePermissions microphonePermissions;
  final String title;
  @override
  State<Tuner> createState() => _TunerState();
}

class _TunerState extends State<Tuner> {
  final _audioRecorder = FlutterAudioCapture();
  final pitchDetectorDart = PitchDetector(44100, 2000);
  // TODO : change instrumentType to the one selected
  final pitchUp = PitchHandler(InstrumentType.guitar);
  MicrophonePermissions permissions = MicrophonePermissions();

  var note = "";
  var status = "Click start";
  Future<void> _startRecording() async {
    if (permissions.isEnabled) {
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
                "The microphones permissions are disable, do you want to request them ?"),
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

  List<_ChartData>? chartData;
  List<TunerChartData>? tunerChartData;
  @override
  void initState() {
    chartData = <_ChartData>[
      _ChartData(2005, 21, 28),
      _ChartData(2006, 24, 44),
      _ChartData(2007, 36, 48),
      _ChartData(2008, 38, 50),
      _ChartData(2009, 54, 66),
      _ChartData(2010, 57, 78),
      _ChartData(2011, 70, 84)
    ];

    tunerChartData = <TunerChartData>[];
    // TODO : Add the data from the tunerChartData list
    // TODO : See https://pub.dev/packages/oscilloscope/example for live chart
    super.initState();
  }

  List<LineSeries<_ChartData, num>> _getDefaultLineSeries() {
    return <LineSeries<_ChartData, num>>[
      LineSeries<_ChartData, num>(
          animationDuration: 2500,
          dataSource: chartData!,
          xValueMapper: (_ChartData sales, _) => sales.x,
          yValueMapper: (_ChartData sales, _) => sales.y,
          width: 2,
          name: 'Germany',
          markerSettings: const MarkerSettings(isVisible: true)),
      LineSeries<_ChartData, num>(
          animationDuration: 2500,
          dataSource: chartData!,
          width: 2,
          name: 'England',
          xValueMapper: (_ChartData sales, _) => sales.x,
          yValueMapper: (_ChartData sales, _) => sales.y2,
          markerSettings: const MarkerSettings(isVisible: true))
    ];
  }

  SfCartesianChart _buildDefaultLineChart(isCardView) {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(text: isCardView ? '' : 'Inflation - Consumer price'),
      legend: Legend(
          isVisible: isCardView ? false : true,
          overflowMode: LegendItemOverflowMode.wrap),
      primaryXAxis: NumericAxis(
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          interval: 2,
          majorGridLines: const MajorGridLines(width: 0)),
      primaryYAxis: NumericAxis(
          labelFormat: '{value}%',
          axisLine: const AxisLine(width: 0),
          majorTickLines: const MajorTickLines(color: Colors.transparent)),
      series: _getDefaultLineSeries(),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text("Drawer Header"),
            ),
            ListTile(
              title: const Text('Stats'),
              onTap: () {
                // TODO : Define navigation
                Navigator.pop(context);
                Navigator.pushNamed(context, '/stats');
              },
            ),
            ListTile(
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/settings');
              },
            ),
          ],
        ),
      ),
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
          Expanded(child: Center(child: _buildDefaultLineChart(true))),
        ]),
      ),
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y, this.y2);
  final double x;
  final double y;
  final double y2;
}
