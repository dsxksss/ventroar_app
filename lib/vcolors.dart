import 'package:flutter/material.dart';

//  夜间模式/常亮模式
bool isDark = true;

class VColors {
  VColors({isDark = true});

  //  模式切换
  changeDark(bool toDark) {
    isDark = toDark;
  }

  //  深背景色
  Color vBg100 = isDark ? const Color.fromRGBO(21, 25, 28, 1) : Colors.white;
  //  浅背景色
  Color vBg90 = isDark ? const Color.fromRGBO(29, 35, 42, 1) : Colors.white70;
  //  次要内容背景色
  Color vBg80 = isDark ? const Color.fromARGB(255, 57, 66, 73) : Colors.white54;
  //  主要文本色
  Color vPtext = isDark ? Colors.white : Colors.black;
  //  次要文本色
  Color vStext = Colors.white60;
  //  shadow阴影色
  Color vShadow = const Color.fromARGB(255, 45, 44, 44);
  //  主要按钮等背景色
  Color vPblue = const Color.fromARGB(255, 56, 128, 255);
  //  次要按钮等背景色
  Color vSblue = const Color.fromRGBO(3, 169, 241, 1);
}
