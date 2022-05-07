import 'package:pitchupdart/instrument_type.dart';

class TunerSettings {
  const TunerSettings(
      {InstrumentType instrumentT = InstrumentType.guitar,
      double baseFrequency = 440})
      : _instrumentType = instrumentT,
        _baseFrequency = baseFrequency;
  final InstrumentType _instrumentType;
  final double _baseFrequency;

  TunerSettings.fromJson(Map<String, dynamic> json)
      : _instrumentType = json['instrumentType'] ?? InstrumentType.guitar,
        _baseFrequency = json['baseFrequency'] ?? 440;

  Map<String, dynamic> toJson() => {
        'instrumentType': _instrumentType.toString(),
        'baseFrequency': _baseFrequency
      };

  InstrumentType get instrumentType {
    return _instrumentType;
  }
}
