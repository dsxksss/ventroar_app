import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
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
            //导航栏高度
            height: 75.0,
            //间隙颜色
            backgroundColor:
                widget.changeToDark ? VColors.vBg90 : Colors.white54,

            //按钮背景颜色
            buttonBackgroundColor:
                widget.changeToDark ? VColors.vBg80 : VColors.vSblue,

            //背景颜色
            color: widget.changeToDark ? VColors.vBg100 : VColors.vSblue,
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
        : Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.black26),
              ),
            ),
            child: GNav(
              backgroundColor: VColors.vPtext,
              iconSize: 27,
              selectedIndex: widget.index,
              onTabChange: (int index) {
                widget.onTap(index);
              },
              gap: 4,
              padding: const EdgeInsets.fromLTRB(40, 13, 40, 33),
              tabs: [
                GButton(
                  icon: widget.index == 0 ? Icons.home : Icons.home_outlined,
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  text: "主 页",
                  iconColor: VColors.vBg100,
                  iconActiveColor: VColors.vBg100,
                ),
                GButton(
                  icon: widget.index == 1
                      ? Icons.star_rounded
                      : Icons.star_border_outlined,
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  text: "星 墙",
                  iconColor: VColors.vBg100,
                  iconActiveColor: VColors.vBg100,
                ),
                GButton(
                  icon: widget.index == 2 ? Icons.person : Icons.person_outline,
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  text: "个 人",
                  iconColor: VColors.vBg100,
                  iconActiveColor: VColors.vBg100,
                ),
              ],
            ),
          );
  }
}
