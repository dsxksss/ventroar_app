import 'dart:ffi';

import 'package:hive/hive.dart';
//flutter packages pub run build_runner build 记得使用此命令生成文件
part "user.g.dart";

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String email;

  @HiveField(3)
  Array friends;

  @HiveField(4)
  Array inBox;

  @HiveField(5)
  int createDate;

  @HiveField(6)
  String avatarUrl;

  @HiveField(7)
  String authToken;

  @HiveField(8)
  bool isOnline;

  @HiveField(9)
  bool isAdmin;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.friends,
    required this.inBox,
    required this.createDate,
    required this.avatarUrl,
    required this.authToken,
    required this.isOnline,
    required this.isAdmin,
  });

  @override
  String toString() {
    return '$name\t$email\t$id';
  }
}
