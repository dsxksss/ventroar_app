import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../databases/user_db.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Box<User> box;

  @override
  void initState() {
    super.initState();
    box = Hive.box("userbox");
  }

  @override
  void dispose() {
    box.close();
    super.dispose();
  }

  void putData() async {
    await box.add(
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
    print(box.getAt(0));
  }

  void removeData() async {
    box.deleteAt(0);
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
      ElevatedButton(
        onPressed: () {
          removeData();
        },
        child: const Text("delete Data"),
      ),
    ]);
  }
}
