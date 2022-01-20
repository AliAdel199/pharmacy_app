// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medicine.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MedicineAdapter extends TypeAdapter<Medicine> {
  @override
  final int typeId = 1;

  @override
  Medicine read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Medicine(
      medName: fields[0] as String?,
      docNote: fields[1] as String?,
      sicNote: fields[2] as String?,
      boxPrice: fields[3] as int?,
      selPrice: fields[4] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Medicine obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.medName)
      ..writeByte(1)
      ..write(obj.docNote)
      ..writeByte(2)
      ..write(obj.sicNote)
      ..writeByte(3)
      ..write(obj.boxPrice)
      ..writeByte(4)
      ..write(obj.selPrice);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MedicineAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
