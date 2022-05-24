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
      location: fields[0] as Position?,
      duration: fields[1] as Duration,
      tracePitch: (fields[2] as List).cast<double>(),
      id: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TunerStats obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.location)
      ..writeByte(1)
      ..write(obj.duration)
      ..writeByte(2)
      ..write(obj.tracePitch)
      ..writeByte(3)
      ..write(obj.id);
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
