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
  bool? isPublic;

  @HiveField(3)
  bool isShowUserName;

  @HiveField(4)
  bool isCanComment;

  @HiveField(5)
  List<dynamic>? smilLikeUsers;

  @HiveField(6)
  List<dynamic>? heartLikeUsers;

  @HiveField(7)
  List<dynamic> textImages;

  @HiveField(8)
  List<RoarComment>? textComments;

  @HiveField(9)
  int textCommentCount;

  @HiveField(10)
  int createDate;

  @HiveField(11)
  int smil;

  @HiveField(12)
  int heart;

  @HiveField(13)
  String userId;

  @HiveField(14)
  String userName;

  @HiveField(15)
  String userEmail;

  @HiveField(16)
  String userAvatarUrl;

  Roar({
    required this.id,
    required this.text,
    required this.isPublic,
    required this.isShowUserName,
    required this.isCanComment,
    required this.smilLikeUsers,
    required this.heartLikeUsers,
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
