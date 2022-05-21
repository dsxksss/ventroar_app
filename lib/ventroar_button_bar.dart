import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import './vcolors.dart';

class VentRoarButtonBar extends StatefulWidget {
  final int index;
  final Function onTap;

  const VentRoarButtonBar({Key? key, required this.onTap, required this.index})
      : super(key: key);

  @override
  State<VentRoarButtonBar> createState() => _VentRoarButtonBarState();
}

class _VentRoarButtonBarState extends State<VentRoarButtonBar> {
  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      ///间隙颜色
      backgroundColor: VColors().vBg90,

      //按钮背景颜色
      buttonBackgroundColor: VColors().vBg80,

      ///背景颜色
      color: VColors().vBg100,
      index: widget.index,

      ///动画曲线
      animationCurve: Curves.easeOutCirc,
      items: [
        Icon(
          Icons.home,
          size: widget.index == 0 ? 30 : 26,
          color: widget.index == 0 ? VColors().vPtext : VColors().vStext,
        ),
        Icon(
          Icons.star_rounded,
          size: widget.index == 1 ? 30 : 26,
          color: widget.index == 1 ? VColors().vPtext : VColors().vStext,
        ),
        Icon(
          Icons.person,
          size: widget.index == 2 ? 30 : 26,
          color: widget.index == 2 ? VColors().vPtext : VColors().vStext,
        ),
      ],
      onTap: (index) {
        widget.onTap(index);
      },
    );
  }

  // final int _currentIndex = 0;
  // @override
  // Widget build(BuildContext context) {
  //   return NavigationBarTheme(
  //     data: NavigationBarThemeData(
  //       indicatorColor: Colors.blue.withOpacity(0.2),
  //       labelTextStyle: MaterialStateProperty.all(
  //         const TextStyle(
  //           fontSize: 16,
  //           fontWeight: FontWeight.bold,
  //           color: VColors.vPtext,
  //         ),
  //       ),
  //     ),
  //     child: NavigationBar(
  //       backgroundColor: Colors.black,
  //       animationDuration: const Duration(seconds: 1),
  //       labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
  //       height: 76,
  //       selectedIndex: _currentIndex,
  //       onDestinationSelected: (int newIndex) {
  //         setState(() {
  //           _currentIndex = newIndex;
  //         });
  //       },
  //       destinations: const [
  //         NavigationDestination(
  //           selectedIcon: Icon(
  //             Icons.home,
  //             size: 28,
  //             color: Colors.blueAccent,
  //           ),
  //           icon: Icon(
  //             Icons.home_outlined,
  //             color: Colors.blue,
  //           ),
  //           label: '主 页',
  //         ),
  //         NavigationDestination(
  //           selectedIcon: Icon(
  //             Icons.star_rounded,
  //             size: 28,
  //             color: Colors.blueAccent,
  //           ),
  //           icon: Icon(
  //             Icons.star_border_outlined,
  //             color: Colors.blue,
  //           ),
  //           label: '心 墙',
  //         ),
  //         NavigationDestination(
  //           selectedIcon: Icon(
  //             Icons.person,
  //             size: 28,
  //             color: Colors.blueAccent,
  //           ),
  //           icon: Icon(
  //             Icons.person_outline,
  //             color: Colors.blue,
  //           ),
  //           label: '我 的',
  //         ),
  //       ],
  //     ),
  //   );

}
