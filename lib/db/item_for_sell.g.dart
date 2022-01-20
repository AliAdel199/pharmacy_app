// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_for_sell.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ItemForSellAdapter extends TypeAdapter<ItemForSell> {
  @override
  final int typeId = 3;

  @override
  ItemForSell read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ItemForSell(
      medName: fields[0] as String?,
      sicNote: fields[1] as String?,
      selPrice: fields[2] as int?,
      itemCount: fields[3] as int?,
      docNote: fields[5] as String?,
      barcode: fields[6] as String?,
    )..itemTotal = fields[4] as int?;
  }

  @override
  void write(BinaryWriter writer, ItemForSell obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.medName)
      ..writeByte(1)
      ..write(obj.sicNote)
      ..writeByte(2)
      ..write(obj.selPrice)
      ..writeByte(3)
      ..write(obj.itemCount)
      ..writeByte(4)
      ..write(obj.itemTotal)
      ..writeByte(5)
      ..write(obj.docNote)
      ..writeByte(6)
      ..write(obj.barcode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemForSellAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
