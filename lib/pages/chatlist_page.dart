import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../pages/chat_page.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({Key? key}) : super(key: key);

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  List<dynamic> userList = [];

  Future getData() async {
    Response response;
    var dio = Dio();
    response = await dio.get('https://jsonplaceholder.typicode.com/users');

    setState(() {
      userList = response.data;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return userList.isEmpty
        ? Center(
            child: LoadingAnimationWidget.stretchedDots(
              color: Colors.blue.shade400,
              size: 60,
            ),
          )
        : RefreshIndicator(
            backgroundColor:
                Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            color: Theme.of(context).floatingActionButtonTheme.backgroundColor,
            onRefresh: () {
              Fluttertoast.showToast(
                msg: "刷新屏幕",
                backgroundColor: Colors.blueAccent,
                gravity: ToastGravity.BOTTOM,
                toastLength: Toast.LENGTH_LONG,
                fontSize: 18,
              );
              return getData();
            },
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(3, 10, 3, 10),
              itemCount: userList.length,
              itemBuilder: (context, index) => Card(
                child: ListTile(
                  onTap: () => {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ChatPage(
                            titleText: userList[index]["name"].toString(),
                            context: context),
                      ),
                    ),
                  },
                  minLeadingWidth: 10,
                  contentPadding: const EdgeInsets.fromLTRB(10, 0, 15, 0),
                  leading: CircleAvatar(
                    radius: 28,
                    foregroundImage: NetworkImage(
                        "https://api.lorem.space/image/face?hash=${Random().nextInt(50)}"),
                  ),
                  title: Text(
                    userList[index]["name"].toString(),
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  subtitle: userList.length <= index
                      ? const Text("whit......")
                      : Text(
                          "Eamil: ${userList[Random().nextInt(10)]["email"].toString()}"),
                  trailing: const Icon(Icons.arrow_forward),
                ),
              ),
            ),
          );
  }
}
