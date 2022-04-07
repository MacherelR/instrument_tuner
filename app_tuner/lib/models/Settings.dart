import 'package:pitchupdart/instrument_type.dart';

class TunerSettings {
  const TunerSettings(
      {InstrumentType instrumentT = InstrumentType.guitar,
      double baseFrequency = 440})
      : _instrumentType = instrumentT,
        _baseFrequency = baseFrequency;
  final InstrumentType _instrumentType;
  final double _baseFrequency;
}
