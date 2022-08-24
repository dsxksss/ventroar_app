import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../contexts/global_provider.dart';

class ChatAppBar extends StatefulWidget implements PreferredSizeWidget {
  const ChatAppBar({Key? key}) : super(key: key);
  @override
  State<ChatAppBar> createState() => _ChatAppBarState();

  //appbar需要实现一个preferredSize接口才可以导出为widget使用
  @override
  Size get preferredSize => const Size.fromHeight(55.0);
}

class _ChatAppBarState extends State<ChatAppBar> {
  @override
  Widget build(BuildContext context) {
    Map pageDatas = Provider.of<PageDataProvider>(context).pageDatas;
    int selectedIndex = Provider.of<PageDataProvider>(context).selectedIndex;
    return AppBar(
      centerTitle: true,
      leading: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
        child: IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: const Icon(
            FontAwesomeIcons.barsStaggered,
            size: 20,
          ),
        ),
      ),
      title: Text(
        "${pageDatas[selectedIndex]}",
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 10, 3),
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
