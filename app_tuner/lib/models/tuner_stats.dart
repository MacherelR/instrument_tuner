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
  TunerStats({this.location, required this.duration, required this.tracePitch, String? id}):
      id = id ?? const Uuid().v4();
}