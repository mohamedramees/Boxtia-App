// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DB_Model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class userModelAdapter extends TypeAdapter<userModel> {
  @override
  final int typeId = 1;

  @override
  userModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return userModel(
      compName: fields[0] as String,
      mobNumber: fields[1] as String,
      password: fields[2] as String,
      Cpassword: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, userModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.compName)
      ..writeByte(1)
      ..write(obj.mobNumber)
      ..writeByte(2)
      ..write(obj.password)
      ..writeByte(3)
      ..write(obj.Cpassword);
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
