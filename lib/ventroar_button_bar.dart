import 'package:flutter/material.dart';

class VentRoarButtonBar extends StatefulWidget {
  const VentRoarButtonBar({Key? key}) : super(key: key);

  @override
  State<VentRoarButtonBar> createState() => _VentRoarButtonBarState();
}

class _VentRoarButtonBarState extends State<VentRoarButtonBar> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationBarTheme(
      data: NavigationBarThemeData(
        indicatorColor: Colors.blue.withOpacity(0.2),
        labelTextStyle: MaterialStateProperty.all(
          const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      child: NavigationBar(
        backgroundColor: Colors.black,
        animationDuration: const Duration(seconds: 1),
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        height: 76,
        selectedIndex: _currentIndex,
        onDestinationSelected: (int newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        destinations: const [
          NavigationDestination(
            selectedIcon: Icon(
              Icons.home,
              size: 28,
              color: Colors.blueAccent,
            ),
            icon: Icon(
              Icons.home_outlined,
              color: Colors.blue,
            ),
            label: '主页',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.star_rounded,
              size: 28,
              color: Colors.blueAccent,
            ),
            icon: Icon(
              Icons.star_border_outlined,
              color: Colors.blue,
            ),
            label: '心墙',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.person,
              size: 28,
              color: Colors.blueAccent,
            ),
            icon: Icon(
              Icons.person_outline,
              color: Colors.blue,
            ),
            label: '我的',
          ),
        ],
      ),
    );
  }
}
