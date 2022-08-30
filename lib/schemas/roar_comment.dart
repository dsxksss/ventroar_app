import 'package:hive/hive.dart';
//flutter packages pub run build_runner build 记得使用此命令生成文件
part "roar_comment.g.dart";

@HiveType(typeId: 2)
class RoarComment extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String commentUserId;

  @HiveField(2)
  String commentName;

  @HiveField(3)
  String commentText;

  @HiveField(4)
  String commentUserAvatarUrl;

  @HiveField(5)
  bool isShowUserName;

  @HiveField(6)
  int createDate;

  RoarComment({
    required this.id,
    required this.commentUserId,
    required this.commentName,
    required this.commentText,
    required this.commentUserAvatarUrl,
    required this.isShowUserName,
    required this.createDate,
  });
}
