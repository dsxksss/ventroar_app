// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'roar_comment.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RoarCommentAdapter extends TypeAdapter<RoarComment> {
  @override
  final int typeId = 2;

  @override
  RoarComment read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RoarComment(
      id: fields[0] as String,
      commentText: fields[1] as String,
      isShowUserName: fields[2] as bool,
      createDate: fields[3] as int,
      userId: fields[4] as String,
      userName: fields[5] as String,
      userEmail: fields[6] as String,
      userAvatarUrl: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, RoarComment obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.commentText)
      ..writeByte(2)
      ..write(obj.isShowUserName)
      ..writeByte(3)
      ..write(obj.createDate)
      ..writeByte(4)
      ..write(obj.userId)
      ..writeByte(5)
      ..write(obj.userName)
      ..writeByte(6)
      ..write(obj.userEmail)
      ..writeByte(7)
      ..write(obj.userAvatarUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RoarCommentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
