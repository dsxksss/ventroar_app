import 'package:hive/hive.dart';
part "user_db.g.dart"; //flutter packages pub run build_runner build 记得使用此命令生成文件

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  int createDate;

  @HiveField(2)
  String name;

  @HiveField(3)
  String email;

  @HiveField(4)
  bool isOnline;

  @HiveField(5)
  bool isAdmin;

  @HiveField(6)
  String avatarUrl;
  User({
    required this.id,
    required this.createDate,
    required this.name,
    required this.email,
    required this.isOnline,
    required this.isAdmin,
    required this.avatarUrl,
  });

  @override
  String toString() {
    return '$name\t$email\t$id';
  }
}
