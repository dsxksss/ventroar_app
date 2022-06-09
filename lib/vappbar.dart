import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VAppBar extends StatefulWidget implements PreferredSizeWidget {
  const VAppBar({Key? key, required this.onPressed}) : super(key: key);

  final VoidCallback onPressed;

  @override
  State<VAppBar> createState() => _VAppBarState();

  //appbar需要实现一个preferredSize接口才可以导出为widget使用
  @override
  Size get preferredSize => const Size.fromHeight(55.0);
}

class _VAppBarState extends State<VAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: const Text(
        "Vent Roar",
      ),
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
            onPressed: widget.onPressed,
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
