import 'package:hive/hive.dart';
//flutter packages pub run build_runner build 记得使用此命令生成文件
part "roar_comment.g.dart";

@HiveType(typeId: 2)
class RoarComment extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String commentText;

  @HiveField(2)
  bool isShowUserName;

  @HiveField(3)
  int createDate;

  @HiveField(4)
  String userId;

  @HiveField(5)
  String userName;

  @HiveField(6)
  String userEmail;

  @HiveField(7)
  String userAvatarUrl;

  RoarComment({
    required this.id,
    required this.commentText,
    required this.isShowUserName,
    required this.createDate,
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.userAvatarUrl,
  });
}
