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
      : _instrumentType =
            stringToInstype(json['instrumentType']) ?? InstrumentType.guitar,
        _baseFrequency = json['baseFrequency'] ?? 440;

  Map<String, dynamic> toJson() => {
        'instrumentType': _instrumentType.toString(),
        'baseFrequency': _baseFrequency
      };

  InstrumentType get instrumentType {
    return _instrumentType;
  }

  double get baseFrequency {
    return _baseFrequency;
  }
}

InstrumentType? stringToInstype(String val) {
  InstrumentType? ret = null;
  switch (val) {
    case "InstrumentType.Guitar":
      {
        ret = InstrumentType.guitar;
        break;
      }
    case "InstrumentType.violin":
      {
        ret = InstrumentType.violin;
        break;
      }
    case "InstrumentType.all":
      {
        ret = InstrumentType.all;
        break;
      }
  }
  return ret;
}
