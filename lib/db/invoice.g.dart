// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InvoiceAdapter extends TypeAdapter<Invoice> {
  @override
  final int typeId = 2;

  @override
  Invoice read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Invoice(
      invID: fields[0] as int?,
      invDate: fields[1] as DateTime?,
      invItems: (fields[3] as List?)?.cast<ItemForSell>(),
      invTotal: fields[2] as int?,
      invTime: fields[4] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, Invoice obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.invID)
      ..writeByte(1)
      ..write(obj.invDate)
      ..writeByte(2)
      ..write(obj.invTotal)
      ..writeByte(3)
      ..write(obj.invItems)
      ..writeByte(4)
      ..write(obj.invTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InvoiceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
