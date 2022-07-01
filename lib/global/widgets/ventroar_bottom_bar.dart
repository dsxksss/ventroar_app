import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../contexts/global_provider.dart';

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
    bool isDark = Provider.of<ThemeProvider>(context).isDark;
    int selectedIndex = Provider.of<PageDataProvider>(context).selectedIndex;
    Function changePageIndex =
        Provider.of<PageDataProvider>(context, listen: false).changePageIndex;
    return DarkAppBar(
      isDark: isDark,
      index: selectedIndex,
      onTap: changePageIndex,
    );
  }
}

class DarkAppBar extends StatefulWidget {
  final int index;
  final Function onTap;
  final bool isDark;

  const DarkAppBar(
      {Key? key,
      required this.onTap,
      required this.index,
      required this.isDark})
      : super(key: key);

  @override
  State<DarkAppBar> createState() => _DarkAppBarState();
}

class _DarkAppBarState extends State<DarkAppBar> {
  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      //导航栏高度
      height: 75.0,
      //间隙颜色
      index: widget.index,

      //间隙颜色
      backgroundColor: Theme.of(context).backgroundColor,

      //按钮背景颜色
      buttonBackgroundColor:
          Theme.of(context).bottomNavigationBarTheme.selectedItemColor!,

      //背景颜色
      color: Theme.of(context).bottomNavigationBarTheme.backgroundColor!,

      //动画曲线
      animationCurve: Curves.easeOutCirc,

      //阻止重复播放动画的判断函数
      letIndexChange: (index) {
        return index == widget.index ? false : true;
      },

      items: [
        Icon(
          Icons.home,
          size: widget.index == 0 ? 31 : 27,
        ),
        Icon(
          Icons.star_rounded,
          size: widget.index == 1 ? 31 : 27,
        ),
        //FIXED:以下代码都是为了修复第三方图标的错误样式
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: FaIcon(
            FontAwesomeIcons.solidComments,
            size: widget.index == 2 ? 24 : 20,
          ),
        ),
        Icon(
          Icons.person,
          size: widget.index == 3 ? 31 : 27,
        ),
      ],
      onTap: (index) {
        widget.onTap(index);
      },
    );
  }
}
