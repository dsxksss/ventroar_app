// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'roar.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RoarAdapter extends TypeAdapter<Roar> {
  @override
  final int typeId = 1;

  @override
  Roar read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Roar(
      id: fields[0] as String,
      text: fields[1] as String,
      isPublic: fields[2] as bool,
      isShowUserName: fields[3] as bool,
      isCanComment: fields[4] as bool,
      likeUsers: (fields[5] as List?)?.cast<String>(),
      textImages: (fields[6] as List).cast<String>(),
      textComments: (fields[7] as List?)?.cast<RoarComment>(),
      textCommentCount: fields[8] as int,
      createDate: fields[9] as int,
      smil: fields[10] as int,
      heart: fields[11] as int,
      userId: fields[12] as String,
      userName: fields[13] as String,
      userEmail: fields[14] as String,
      userAvatarUrl: fields[15] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Roar obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.text)
      ..writeByte(2)
      ..write(obj.isPublic)
      ..writeByte(3)
      ..write(obj.isShowUserName)
      ..writeByte(4)
      ..write(obj.isCanComment)
      ..writeByte(5)
      ..write(obj.likeUsers)
      ..writeByte(6)
      ..write(obj.textImages)
      ..writeByte(7)
      ..write(obj.textComments)
      ..writeByte(8)
      ..write(obj.textCommentCount)
      ..writeByte(9)
      ..write(obj.createDate)
      ..writeByte(10)
      ..write(obj.smil)
      ..writeByte(11)
      ..write(obj.heart)
      ..writeByte(12)
      ..write(obj.userId)
      ..writeByte(13)
      ..write(obj.userName)
      ..writeByte(14)
      ..write(obj.userEmail)
      ..writeByte(15)
      ..write(obj.userAvatarUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RoarAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
