import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:ventroar_app/databases/userdb/user_db.dart';
import 'package:ventroar_app/functions/vent_snack.dart';
import 'package:ventroar_app/schemas/user.dart';
import 'package:ventroar_app/widgets/vent_slidable.dart';
import '../contexts/global_provider.dart';
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
  Widget build(BuildContext context) {
    bool _isDark = Provider.of<ThemeProvider>(context, listen: true).isDark;
    return isLoading
        ? _isDark
            ? Container(
                color: Theme.of(context)
                    .appBarTheme
                    .foregroundColor!
                    .withOpacity(0),
                width: 200,
                height: 200,
                child: const RiveAnimation.asset(
                    'static/animations/dark/wait_d.riv'),
              )
            : const SizedBox(
                width: 200,
                height: 200,
                child:
                    RiveAnimation.asset('static/animations/light/wait_l.riv'),
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
                ? ListView(children: [
                    Center(
                      child: Text(
                        '您还没有联系人',
                        style: TextStyle(
                            color: Theme.of(context)
                                .appBarTheme
                                .titleTextStyle
                                ?.color,
                            fontSize: 24),
                      ),
                    ),
                    Center(
                      child: Text(
                        '尝试下拉随机添加部分联系人',
                        style: TextStyle(
                            color: Theme.of(context)
                                .appBarTheme
                                .titleTextStyle
                                ?.color,
                            fontSize: 24),
                      ),
                    ),
                  ])
                : ListView.builder(
                    //确定每一个item的高度 会让item加载更加高效
                    itemExtent: 80,
                    primary: false,
                    physics: userList.length > 10
                        ? const BouncingScrollPhysics()
                        : const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(3, 0, 3, 10),
                    itemCount: userList.length,
                    itemBuilder: (context, index) => VSlidable(
                      onPressed: (sliderContext) => {
                        setState(() {
                          UserDB.instance.deleteUser(userList[index].id!);
                          userList.remove(userList[index]);
                        }),
                      },
                      widget: ListTile(
                        tileColor: Theme.of(context).canvasColor,
                        onLongPress: () {
                          vSnackBar(
                            context: context,
                            textWidget: const Text(
                              "是否清空用户聊天列表?",
                              style: TextStyle(fontSize: 20),
                            ),
                            button: ElevatedButton(
                              onPressed: () => {
                                setState(() {
                                  UserDB.instance.deleteAllUsers();
                                  userList.clear();
                                }),
                                //隐藏上下文内的SnackBar
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar(
                                        reason: SnackBarClosedReason.action),
                              },
                              child: const Text("删除全部"),
                            ),
                          );
                        },
                        onTap: () => {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ChatPage(
                                titleText: userList[index].userName.toString(),
                                context: context,
                              ),
                            ),
                          ),
                        },
                        minLeadingWidth: 10,
                        contentPadding: const EdgeInsets.fromLTRB(10, 5, 15, 5),
                        leading: CircleAvatar(
                          radius: 28,
                          foregroundImage:
                              NetworkImage(userList[index].userImgUrl),
                        ),
                        title: Container(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                          child: Text(
                            userList[index].userName.toString(),
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        subtitle: const Text("用户的最新聊天记录信息"),
                        trailing: SizedBox(
                          width: 80,
                          child: Column(
                            children: [
                              Expanded(
                                child:
                                    Text(userList[index].createTime.toString()),
                              ),
                              const Icon(
                                Icons.arrow_forward,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
          );
  }
}
