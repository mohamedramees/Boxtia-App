// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DB_Model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class userModelAdapter extends TypeAdapter<userModel> {
  @override
  final int typeId = 0;

  @override
  userModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return userModel(
      bussinessName: fields[0] as String,
      bussiType: fields[1] as String,
      oName: fields[2] as String,
      place: fields[3] as String,
      mobileNumber: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, userModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.bussinessName)
      ..writeByte(1)
      ..write(obj.bussiType)
      ..writeByte(2)
      ..write(obj.oName)
      ..writeByte(3)
      ..write(obj.place)
      ..writeByte(4)
      ..write(obj.mobileNumber);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is userModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class itemModelAdapter extends TypeAdapter<itemModel> {
  @override
  final int typeId = 1;

  @override
  itemModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return itemModel(
      ItemPicM: fields[0] as String,
      CategoryM: fields[1] as String,
      ItemNameM: fields[2] as String,
      ColorM: fields[3] as String,
      PriceM: fields[4] as String,
      BrandM: fields[5] as String,
      CountM: fields[6] as String,
      QuantityM: fields[7] as int,
    );
  }

  @override
  void write(BinaryWriter writer, itemModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.ItemPicM)
      ..writeByte(1)
      ..write(obj.CategoryM)
      ..writeByte(2)
      ..write(obj.ItemNameM)
      ..writeByte(3)
      ..write(obj.ColorM)
      ..writeByte(4)
      ..write(obj.PriceM)
      ..writeByte(5)
      ..write(obj.BrandM)
      ..writeByte(6)
      ..write(obj.CountM)
      ..writeByte(7)
      ..write(obj.QuantityM);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is itemModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class customerModelAdapter extends TypeAdapter<customerModel> {
  @override
  final int typeId = 2;

  @override
  customerModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return customerModel(
      customerNameM: fields[0] as String,
      customerNumberM: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, customerModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.customerNameM)
      ..writeByte(1)
      ..write(obj.customerNumberM);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is customerModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
