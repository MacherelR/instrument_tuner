library pitch_detector_dart;

import 'pitch_detector_result.dart';

import 'algorithm/pitch_algorithm.dart';
import 'algorithm/yin.dart';

class PitchDetector {
  final PitchAlgorithm _pitchAlgorithm;

  PitchDetector(double audioSampleRate, int bufferSize)
      : this._pitchAlgorithm = new Yin(audioSampleRate, bufferSize);

  PitchDetectorResult getPitch(final List<double> audioBuffer) {
    return _pitchAlgorithm.getPitch(audioBuffer);
  }
}
