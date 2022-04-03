// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expiresoon.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExpireItemSoonAdapter extends TypeAdapter<ExpireItemSoon> {
  @override
  final int typeId = 6;

  @override
  ExpireItemSoon read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExpireItemSoon(
      barcode: fields[0] as String?,
      expired: fields[2] as DateTime?,
      itemName: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ExpireItemSoon obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.barcode)
      ..writeByte(1)
      ..write(obj.itemName)
      ..writeByte(2)
      ..write(obj.expired);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpireItemSoonAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
