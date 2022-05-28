import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:hive/hive.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';
part 'tuner_stats.g.dart';
@HiveType(typeId: 0)
class TunerStats{
  @HiveField(0)
  Position? location;
  @HiveField(1)
  Duration duration;
  @HiveField(2)
  List<double> tracePitch;
  @HiveField(3)
  String id;
  @HiveField(4)
  DateTime date;
  TunerStats({this.location, required this.duration, required this.tracePitch, required this.date, String? id}):
      id = id ?? const Uuid().v4();
}

/// Adapter for duration in seconds
class DurationAdapter extends TypeAdapter<Duration>{
  @override
  int typeId = 5;
  @override
  Duration read(BinaryReader reader){
    return Duration(seconds: reader.read());
  }

  @override
  void write(BinaryWriter writer, Duration obj){
    writer.write(obj.inSeconds);
  }
}

//   Future<void> _saveRandomStat() async{
//     Duration dur = const Duration(hours: 1, minutes: 1, seconds: 2);
//     List<double> trace = [446,448,450,457,498,422,435,440];
//     TunerStats rdm = TunerStats(duration: dur, tracePitch: trace);
//     await context.read<TunerRepository>().saveStat(rdm);
// }