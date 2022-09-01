import 'package:hive/hive.dart';
import 'roar_comment.dart';
//flutter packages pub run build_runner build 记得使用此命令生成文件
part "roar.g.dart";

@HiveType(typeId: 1)
class Roar extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String text;

  @HiveField(2)
  bool isPublic;

  @HiveField(3)
  bool isShowUserName;

  @HiveField(4)
  bool isCanComment;

  @HiveField(5)
  List<String>? likeUsers;

  @HiveField(6)
  List<String> textImages;

  @HiveField(7)
  List<RoarComment>? textComments;

  @HiveField(8)
  int textCommentCount;

  @HiveField(9)
  int createDate;

  @HiveField(10)
  int smil;

  @HiveField(11)
  int heart;

  @HiveField(12)
  String userId;

  @HiveField(13)
  String userName;

  @HiveField(14)
  String userEmail;

  @HiveField(15)
  String userAvatarUrl;

  Roar({
    required this.id,
    required this.text,
    required this.isPublic,
    required this.isShowUserName,
    required this.isCanComment,
    required this.likeUsers,
    required this.textImages,
    required this.textComments,
    required this.textCommentCount,
    required this.createDate,
    required this.smil,
    required this.heart,
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.userAvatarUrl,
  });
}
