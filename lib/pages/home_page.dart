import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../databases/user_db.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void putData() async {
    var box = Hive.box("userBox");
    await box.put(
      "x",
      User(
        name: "Jack",
        email: "2546650292@qq.com",
        isOline: false,
        isAdmin: true,
        avatarUrl: "狗头.jpg",
        id: "x21y2717jghx",
        createDate: 12345678,
      ),
    );
  }

  void readData() async {
    var box = Hive.box("userBox");
    User obj = await box.get("x");
    print(obj);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      ElevatedButton(
        onPressed: () {
          putData();
        },
        child: const Text("put Data"),
      ),
      ElevatedButton(
        onPressed: () {
          readData();
        },
        child: const Text("read Data"),
      ),
    ]);
  }
}
