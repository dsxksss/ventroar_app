import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../contexts/global_provider.dart';

class VentRoarButtonBar extends StatefulWidget {
  const VentRoarButtonBar({
    Key? key,
  }) : super(key: key);
  @override
  State<VentRoarButtonBar> createState() => _VentRoarButtonBarState();
}

class _VentRoarButtonBarState extends State<VentRoarButtonBar> {
  @override
  Widget build(BuildContext context) {
    int selectedIndex = context.watch<PageDataProvider>().selectedIndex;
    Function changePageIndex =
        Provider.of<PageDataProvider>(context, listen: false).changePageIndex;
    return BottomNavigationBar(
      //init Index
      currentIndex: selectedIndex,

      //阴影
      elevation: 0,

      //改变indexCallBack
      onTap: (index) => changePageIndex(index),

      //选中时的字体大小
      selectedFontSize: 20.sp,

      //未选中时的字体大小
      unselectedFontSize: 20.sp,

      //背景色
      backgroundColor:
          Theme.of(context).bottomNavigationBarTheme.backgroundColor!,

      //按钮选中色
      selectedItemColor:
          Theme.of(context).bottomNavigationBarTheme.selectedItemColor!,

      //按钮未选中色
      unselectedItemColor:
          Theme.of(context).bottomNavigationBarTheme.unselectedItemColor!,

      //显示类型
      type: BottomNavigationBarType.fixed,

      //是否显示选中时的label
      showSelectedLabels: false,

      //是否显示未选中时的label
      showUnselectedLabels: false,

      items: const [
        BottomNavigationBarItem(
          label: "主页",
          icon: FaIcon(FontAwesomeIcons.solidBell),
          activeIcon: FaIcon(FontAwesomeIcons.solidHourglass),
        ),
        BottomNavigationBarItem(
          label: "心墙",
          icon: FaIcon(FontAwesomeIcons.star),
          activeIcon: FaIcon(FontAwesomeIcons.solidStar),
        ),
        BottomNavigationBarItem(
          label: "消息",
          icon: FaIcon(FontAwesomeIcons.comments),
        ),
        BottomNavigationBarItem(
          label: "个人",
          icon: FaIcon(FontAwesomeIcons.user),
        ),
      ],
    );
  }
}
