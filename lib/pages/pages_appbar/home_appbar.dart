import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../contexts/global_provider.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  const HomeAppBar({Key? key}) : super(key: key);
  @override
  State<HomeAppBar> createState() => _HomeAppBarState();

  //appbar需要实现一个preferredSize接口才可以导出为widget使用
  @override
  Size get preferredSize => const Size.fromHeight(55.0);
}

class _HomeAppBarState extends State<HomeAppBar> {
  @override
  Widget build(BuildContext context) {
    Map pageDatas = Provider.of<PageDataProvider>(context).pageDatas;
    int selectedIndex = Provider.of<PageDataProvider>(context).selectedIndex;
    return AppBar(
      centerTitle: true,
      title: Text("${pageDatas[selectedIndex]}"),
      actions: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: IconButton(
            splashColor: const Color.fromARGB(0, 255, 255, 255),
            icon: Badge(
              //提醒圆点
              badgeColor: Colors.red,
              // padding: const EdgeInsets.fromLTRB(5, 5, 15, 5),
              badgeContent: const Text("1",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white)),
              child: const FaIcon(
                FontAwesomeIcons.solidEnvelope,
                size: 20,
              ),
            ),
            tooltip: '查看消息',
            onPressed: () {
              Provider.of<PageDataProvider>(context, listen: false)
                  .changePageIndex(2);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 5, 3),
          child: IconButton(
            splashColor: const Color.fromARGB(0, 255, 255, 255),
            icon: const Icon(
              FontAwesomeIcons.userPlus,
              size: 20,
            ),
            tooltip: '添加好友',
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
