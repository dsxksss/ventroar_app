import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:ventroar_app/databases/userdb/user_db.dart';
import 'package:ventroar_app/schemas/user.dart';
import 'package:ventroar_app/widgets/vent_slidable.dart';
import '../pages/chat_page.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({Key? key}) : super(key: key);

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  late List<User> userList;
  bool isLoading = false;

  Future fetchAndUpDate() async {
    Response response;
    var dio = Dio();
    response = await dio.get('https://jsonplaceholder.typicode.com/users');
    List<dynamic> a = response.data as List<dynamic>;

    for (var e in a) {
      {
        User result = User(
          createTime: DateTime.now(),
          userName: e["name"].toString(),
          userImgUrl:
              "https://api.lorem.space/image/face?https://api.lorem.space/image/face?hash=${Random().nextInt(50)}"
                  .toString(),
          isAdmin: false,
        );
        userList.add(await UserDB.instance.createUser(result));
      }
    }

    setState(() {
      readAndLodingAllUsers();
    });
  }

  Future readAndLodingAllUsers() async {
    setState(() {
      isLoading = true;
    });
    userList = await UserDB.instance.readAllUsers();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    readAndLodingAllUsers();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
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
              return fetchAndUpDate();
            },
            child: userList.isEmpty
                ? ListView(children: const [
                    Center(
                      child: Text(
                        '您还没有联系人',
                        style: TextStyle(color: Colors.black, fontSize: 24),
                      ),
                    ),
                    Center(
                      child: Text(
                        '尝试下拉随机添加部分联系人',
                        style: TextStyle(color: Colors.black, fontSize: 24),
                      ),
                    ),
                  ])
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(3, 10, 3, 10),
                    itemCount: userList.length,
                    itemBuilder: (context, index) => Card(
                      child: VSlidable(
                        onPressed: (sliderContext) => {
                          setState(() {
                            userList.remove(userList[index]);
                          }),
                          UserDB.instance.deleteUser(userList[index].id!),
                        },
                        widget: ListTile(
                          onTap: () => {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ChatPage(
                                  titleText:
                                      userList[index].userName.toString(),
                                  context: context,
                                ),
                              ),
                            ),
                          },
                          minLeadingWidth: 10,
                          contentPadding:
                              const EdgeInsets.fromLTRB(10, 0, 15, 0),
                          leading: CircleAvatar(
                            radius: 28,
                            foregroundImage:
                                NetworkImage(userList[index].userImgUrl),
                          ),
                          title: Text(
                            userList[index].userName.toString(),
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          subtitle: userList.length <= index
                              ? const Text("whit......")
                              : Text(
                                  "Create Time: ${userList[index].createTime.toString()}"),
                          trailing: const Icon(
                            Icons.arrow_forward,
                          ),
                        ),
                      ),
                    ),
                  ),
          );
  }
}
