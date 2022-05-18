import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

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
      backgroundColor: const Color.fromRGBO(29, 35, 42, 1),

      //按钮背景颜色
      buttonBackgroundColor: const Color.fromRGBO(44, 52, 58, 1),

      ///背景颜色
      color: const Color.fromRGBO(21, 25, 28, 1),
      index: widget.index,

      ///动画曲线
      animationCurve: Curves.easeOutCirc,
      items: const [
        Icon(
          Icons.home,
          size: 28,
          color: Colors.white,
        ),
        Icon(
          Icons.star_rounded,
          size: 28,
          color: Colors.white,
        ),
        Icon(
          Icons.person,
          size: 28,
          color: Colors.white,
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
  //           color: Colors.white,
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
