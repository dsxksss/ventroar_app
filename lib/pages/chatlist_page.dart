import 'dart:math';
import 'package:badges/badges.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ventroar_app/functions/timestamp_conversion.dart';
import 'package:ventroar_app/functions/vent_snack.dart';
import 'package:ventroar_app/schemas/user_friend.dart';
import 'package:ventroar_app/widgets/vent_slidable.dart';
import 'package:ventroar_app/widgets/wait_animation.dart';
import '../databases/user_friends_db.dart';
import '../functions/curren_time_millis.dart';
import '../pages/chat_page.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({Key? key}) : super(key: key);

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  late List<UserFriend> userList;
  bool isLoading = false;

  Future fetchAndUpDate() async {
    vSnackBar(
      showTime: const Duration(seconds: 2),
      context: context,
      model: VSnackModel.success,
      textWidget: Text(
        "刷新屏幕",
        style: TextStyle(
          fontSize: 17.sp,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    Response response;
    var dio = Dio();
    try {
      response = await dio.get('https://jsonplaceholder.typicode.com/users');
      List<dynamic> a = response.data as List<dynamic>;
      for (var e in a) {
        {
          UserFriend result = UserFriend(
            createDate: currentTimeMillis(),
            friendName: e["name"].toString(),
            avatarUrl:
                "https://api.lorem.space/image/face?hash=${Random().nextInt(50)}"
                    .toString(),
            isOnlien: false,
          );
          userList.add(await UserFriendDB.instance.createUser(result));
        }
      }
      setState(() {
        readAndLodingAllUsers();
      });
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        vSnackBar(
          context: context,
          model: VSnackModel.error,
          textWidget: Text(
            "数据没找到,请检查重试...",
            style: TextStyle(fontSize: 15.sp, color: Colors.white),
          ),
        );
      } else {
        vSnackBar(
          context: context,
          model: VSnackModel.error,
          textWidget: Text(
            "网络繁忙,获取联系人失败,请重试...",
            style: TextStyle(fontSize: 15.sp, color: Colors.white),
          ),
        );
      }
    }
  }

  Future readAndLodingAllUsers() async {
    setState(() {
      isLoading = true;
    });
    userList = await UserFriendDB.instance.readAllUsers();
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
    return isLoading
        ? const WaitAnimation()
        : RefreshIndicator(
            backgroundColor:
                Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            color: Theme.of(context).floatingActionButtonTheme.backgroundColor,
            onRefresh: () {
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
                    itemExtent: 83,
                    primary: false,
                    physics: const AlwaysScrollableScrollPhysics(
                      //当内容不足时也可以启动反弹刷新
                      parent: BouncingScrollPhysics(),
                    ),
                    padding: const EdgeInsets.fromLTRB(3, 0, 3, 10),
                    itemCount: userList.length,
                    itemBuilder: (context, index) => VSlidable(
                      onPressed: (sliderContext) => {
                        setState(() {
                          UserFriendDB.instance.deleteUser(userList[index].id!);
                          userList.remove(userList[index]);
                        }),
                      },
                      widget: ListTile(
                        onLongPress: () {
                          vSnackBar(
                            context: context,
                            model: VSnackModel.error,
                            textWidget: Text(
                              "是否清空用户聊天列表?",
                              style: TextStyle(
                                  fontSize: 17.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            button: TextButton.icon(
                              onPressed: () => {
                                setState(() {
                                  UserFriendDB.instance.deleteAllUsers();
                                  userList.clear();
                                }),
                                //隐藏上下文内的SnackBar
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar(
                                        reason: SnackBarClosedReason.action),
                              },
                              label: Text(
                                "确定",
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              icon: const Icon(
                                Icons.delete,
                              ),
                            ),
                          );
                        },
                        onTap: () => {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ChatPage(
                                titleText:
                                    userList[index].friendName.toString(),
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
                              NetworkImage(userList[index].avatarUrl),
                        ),
                        title: Container(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                          child: Text(
                            userList[index].friendName.toString(),
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        subtitle: const Text("用户的最新聊天记录信息"),
                        trailing: SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Text(timestampConversion(
                                    userList[index].createDate)),
                              ),
                              VBadge(
                                count: Random().nextInt(120),
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

class VBadge extends StatelessWidget {
  const VBadge({
    Key? key,
    required this.count,
  }) : super(key: key);
  final int count;
  @override
  Widget build(BuildContext context) {
    return count >= 99
        ? Badge(
            toAnimate: false,
            shape: BadgeShape.square,
            badgeColor: Colors.grey,
            borderRadius: BorderRadius.circular(20),
            padding: const EdgeInsets.all(2),
            badgeContent: Text('99+',
                style: TextStyle(color: Colors.white, fontSize: 11.sp)),
          )
        : Badge(
            toAnimate: false,
            borderRadius: BorderRadius.circular(20),
            badgeColor: Colors.grey,
            padding:
                count >= 10 ? const EdgeInsets.all(3) : const EdgeInsets.all(6),
            badgeContent: Text(
              count.toString(),
              style: TextStyle(
                  color: Colors.white, fontSize: count >= 10 ? 12.sp : 13.sp),
            ),
          );
  }
}
