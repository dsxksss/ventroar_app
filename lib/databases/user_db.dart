import 'package:hive/hive.dart';
part "user_db.g.dart";

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
  bool isOline;

  @HiveField(5)
  bool isAdmin;

  @HiveField(6)
  String avatarUrl;
  User({
    required this.id,
    required this.createDate,
    required this.name,
    required this.email,
    required this.isOline,
    required this.isAdmin,
    required this.avatarUrl,
  });

  @override
  String toString() {
    return '$name\t$email\t$id';
  }
}
