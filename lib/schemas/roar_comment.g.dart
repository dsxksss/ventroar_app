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
      commentUserId: fields[1] as String,
      commentName: fields[2] as String,
      commentText: fields[3] as String,
      commentUserAvatarUrl: fields[4] as String,
      isShowUserName: fields[5] as bool,
      createDate: fields[6] as int,
    );
  }

  @override
  void write(BinaryWriter writer, RoarComment obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.commentUserId)
      ..writeByte(2)
      ..write(obj.commentName)
      ..writeByte(3)
      ..write(obj.commentText)
      ..writeByte(4)
      ..write(obj.commentUserAvatarUrl)
      ..writeByte(5)
      ..write(obj.isShowUserName)
      ..writeByte(6)
      ..write(obj.createDate);
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
