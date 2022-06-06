import 'package:flutter/material.dart';

class VDrawer extends StatefulWidget {
  final List<VoidCallback> onTap;
  final int index;
  final String userName = "zhangxiaokang";
  final String uesrEmail = "2546650292@qq.com";
  const VDrawer({
    Key? key,
    required this.onTap,
    required this.index,
  }) : super(key: key);

  @override
  State<VDrawer> createState() => _VDrawerState();
}

class _VDrawerState extends State<VDrawer> {
  double titleTextSize = 20;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        primary: true, //如果内容不足用户可以滚动
        physics: const AlwaysScrollableScrollPhysics(),

        /// physics 属性接受一个ScrollPhysics类型的对象，它决定可滚动组件如何响应用户操作，
        /// 比如用户滑动完抬起手指后，继续执行动画；或者滑动到边界时，如何显示。
        /// 默认情况下，Flutter会根据具体平台分别使用不同的ScrollPhysics对象，
        /// 应用不同的显示效果，如当滑动到边界时，继续拖动的话，在iOS上会出现弹性效果，
        /// 而在Android上会出现微光效果。如果你想在所有平台下使用同一种效果，
        /// 可以显式指定一个固定的ScrollPhysics，Flutter SDK中包含了两个ScrollPhysics的子类，
        /// 他们可以直接使用：

        /// 这个属性几个滑动的选择
        /// AlwaysScrollableScrollPhysics() 总是可以滑动
        /// NeverScrollableScrollPhysics 禁止滚动
        /// BouncingScrollPhysics 内容超过一屏 上拉有回弹效果（iOS下弹性效果）
        /// ClampingScrollPhysics 包裹内容 不会有回弹（Android下微光效果）
        children: [
          DrawerHeader(
              padding: const EdgeInsets.fromLTRB(20, 40, 10, 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                    child: Text(
                      '@${widget.userName}',
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 23,
                      ),
                    ),
                  ),
                  Text(
                    widget.uesrEmail,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  )
                ],
              )),
          ListTile(
            title: Text(
              "主页",
              style: TextStyle(
                fontSize: titleTextSize,
              ),
            ),

            //副标题
            // subtitle: const Text(
            //   "回到主页",
            //   style: TextStyle(
            //     fontSize: 17,
            //   ),
            // ),

            leading: Icon(widget.index == 0 ? Icons.home : Icons.home_outlined),
            onTap: widget.onTap[0],
            selected: widget.index == 0 ? true : false,
            selectedColor: const Color.fromARGB(255, 56, 128, 255),
            selectedTileColor: const Color.fromARGB(79, 56, 129, 255),
          ),
          ListTile(
            title: Text(
              "星墙",
              style: TextStyle(
                fontSize: titleTextSize,
              ),
            ),
            leading: Icon(widget.index == 1
                ? Icons.star_rounded
                : Icons.star_border_outlined),
            onTap: widget.onTap[1],
            selected: widget.index == 1 ? true : false,
            selectedColor: const Color.fromARGB(255, 56, 128, 255),
            selectedTileColor: const Color.fromARGB(79, 56, 129, 255),
          ),
          ListTile(
            title: Text(
              "聊天页面",
              style: TextStyle(
                fontSize: titleTextSize,
              ),
            ),
            leading: Icon(widget.index == 2
                ? Icons.text_snippet_rounded
                : Icons.text_snippet_outlined),
            onTap: widget.onTap[2],
            selected: widget.index == 2 ? true : false,
            selectedColor: const Color.fromARGB(255, 56, 128, 255),
            selectedTileColor: const Color.fromARGB(79, 56, 129, 255),
          ),
          ListTile(
            title: Text(
              "个人信息",
              style: TextStyle(
                fontSize: titleTextSize,
              ),
            ),
            leading:
                Icon(widget.index == 3 ? Icons.person : Icons.person_outline),
            onTap: widget.onTap[3],
            selected: widget.index == 3 ? true : false,
            selectedColor: const Color.fromARGB(255, 56, 128, 255),
            selectedTileColor: const Color.fromARGB(79, 56, 129, 255),
          ),
        ],
      ),
    );
  }
}
