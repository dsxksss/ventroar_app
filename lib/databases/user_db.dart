import 'package:hive/hive.dart';

class User {
  final String id;
  final int createDate;
  final String name;
  final String email;
  final bool isOline;
  final bool isAdmin;
  final String avatarUrl;
  User({
    required this.name,
    required this.email,
    required this.isOline,
    required this.isAdmin,
    required this.avatarUrl,
    required this.id,
    required this.createDate,
  });

  @override
  String toString() {
    return '$name\t$email\t$id';
  }
}

// Can be generated automatically
class UserAdapter extends TypeAdapter<User> {
  @override
  final typeId = 1;

  @override
  User read(BinaryReader reader) {
    return User(
      name: reader.readString(),
      email: reader.readString(),
      isOline: reader.readBool(),
      isAdmin: reader.readBool(),
      avatarUrl: reader.readString(),
      id: reader.readString(),
      createDate: reader.readInt32(),
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer.write(obj.id);
    writer.write(obj.name);
    writer.write(obj.email);
    writer.write(obj.avatarUrl);
    writer.write(obj.createDate);
    writer.write(obj.isAdmin);
    writer.write(obj.isOline);
  }
}
