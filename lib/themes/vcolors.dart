import 'package:flutter/material.dart';

class VColors {
  //  深背景色
  static Color vBg100 = const Color.fromRGBO(21, 25, 28, 1);
  //  浅背景色
  static Color vBg90 = const Color.fromRGBO(29, 35, 42, 1);
  //  次要内容背景色
  static Color vBg80 = const Color.fromARGB(255, 57, 66, 73);
  //  主要文本色
  static Color vPtext = Colors.white;
  //  次要文本色
  static Color vStext = Colors.white60;
  //  shadow阴影色
  static Color vShadow = const Color.fromARGB(255, 45, 44, 44);
  //  主要按钮等背景色
  static Color vPblue = const Color.fromARGB(255, 56, 128, 255);
  //  次要按钮等背景色
  static Color vSblue = const Color.fromARGB(255, 0, 174, 243);
}

class VLightThemeColors {
  //页面色
  static Color pageBG = VColors.vStext;
  //图标颜色
  static Color iconColor = VColors.vBg90;

  //头部导航栏颜色集
  static Map appBarColors = {
    "bg": VColors.vPtext,
    "foregroundColor": VColors.vBg100,
  };

  //侧边导航栏颜色集
  static Map drawerColors = {
    "bg": VColors.vPtext,
  };

  //底部导航栏颜色集
  static Map bottomNavColors = {
    "selectedItemColor": const Color.fromARGB(255, 230, 234, 236),
    "unselectedItemColor": VColors.vPtext,
    "bg": const Color.fromARGB(255, 178, 195, 209),
  };
}

class VDarkThemeColors {
  //页面色
  static Color pageBG = VColors.vBg90;
  //图标颜色
  static Color iconColor = VColors.vPtext;

  //头部导航栏颜色集
  static Map appBarColors = {
    "bg": VColors.vBg100,
    "foregroundColor": VColors.vPtext,
  };

  //侧边导航栏颜色集
  static Map drawerColors = {
    "bg": VColors.vBg100,
  };

  //底部导航栏颜色集
  static Map bottomNavColors = {
    "selectedItemColor": VColors.vBg80,
    "unselectedItemColor": VColors.vPtext,
    "bg": VColors.vBg100,
  };
}
