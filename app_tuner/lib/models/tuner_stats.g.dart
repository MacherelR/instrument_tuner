// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tuner_stats.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TunerStatsAdapter extends TypeAdapter<TunerStats> {
  @override
  final int typeId = 0;

  @override
  TunerStats read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TunerStats(
      latitude: fields[5] as double?,
      longitude: fields[6] as double?,
      duration: fields[1] as Duration,
      tracePitch: (fields[2] as List).cast<double>(),
      date: fields[4] as DateTime,
      id: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TunerStats obj) {
    writer
      ..writeByte(6)
      ..writeByte(1)
      ..write(obj.duration)
      ..writeByte(2)
      ..write(obj.tracePitch)
      ..writeByte(3)
      ..write(obj.id)
      ..writeByte(4)
      ..write(obj.date)
      ..writeByte(5)
      ..write(obj.latitude)
      ..writeByte(6)
      ..write(obj.longitude);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TunerStatsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
