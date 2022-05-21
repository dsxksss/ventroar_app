import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import './vcolors.dart';

class VentRoarButtonBar extends StatefulWidget {
  final int index;
  final Function onTap;
  final bool changeToDark;

  const VentRoarButtonBar(
      {Key? key,
      required this.onTap,
      required this.index,
      required this.changeToDark})
      : super(key: key);

  @override
  State<VentRoarButtonBar> createState() => _VentRoarButtonBarState();
}

class _VentRoarButtonBarState extends State<VentRoarButtonBar> {
  @override
  Widget build(BuildContext context) {
    return widget.changeToDark
        ? CurvedNavigationBar(
            ///间隙颜色
            backgroundColor:
                widget.changeToDark ? VColors.vBg90 : Colors.white54,

            //按钮背景颜色
            buttonBackgroundColor:
                widget.changeToDark ? VColors.vBg80 : VColors.vPblue,

            ///背景颜色
            color: widget.changeToDark ? VColors.vBg100 : VColors.vPblue,
            index: widget.index,

            ///动画曲线
            animationCurve: Curves.easeOutCirc,
            items: [
              Icon(
                Icons.home,
                size: widget.index == 0 ? 30 : 26,
              ),
              Icon(
                Icons.star_rounded,
                size: widget.index == 1 ? 30 : 26,
              ),
              Icon(
                Icons.person,
                size: widget.index == 2 ? 30 : 26,
              ),
            ],
            onTap: (index) {
              widget.onTap(index);
            },
          )
        : NavigationBarTheme(
            data: NavigationBarThemeData(
              backgroundColor: Colors.white,
              indicatorColor:
                  const Color.fromARGB(255, 180, 186, 190).withOpacity(0.2),
              labelTextStyle: MaterialStateProperty.all(
                const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.black26),
                ),
              ),
              child: NavigationBar(
                animationDuration: const Duration(milliseconds: 800),
                labelBehavior:
                    NavigationDestinationLabelBehavior.onlyShowSelected,
                height: 75,
                selectedIndex: widget.index,
                onDestinationSelected: (int index) {
                  widget.onTap(index);
                },
                destinations: const [
                  NavigationDestination(
                    selectedIcon: Icon(
                      Icons.home,
                      size: 28,
                    ),
                    icon: Icon(
                      Icons.home_outlined,
                    ),
                    label: '主 页',
                  ),
                  NavigationDestination(
                    selectedIcon: Icon(
                      Icons.star_rounded,
                      size: 28,
                    ),
                    icon: Icon(
                      Icons.star_border_outlined,
                    ),
                    label: '心 墙',
                  ),
                  NavigationDestination(
                    selectedIcon: Icon(
                      Icons.person,
                      size: 28,
                    ),
                    icon: Icon(
                      Icons.person_outline,
                    ),
                    label: '我 的',
                  ),
                ],
              ),
            ),
          );
  }
}
