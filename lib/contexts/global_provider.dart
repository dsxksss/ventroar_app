import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//昼夜主题值:isDark提供者
class ThemeProvider extends ChangeNotifier {
  bool isDark;
  late bool? phoneDark;

  ThemeProvider({this.isDark = true}) {
    initThemeData();
  }

  void initThemeData() async {
    var perfs = await SharedPreferences.getInstance();
    phoneDark = perfs.getBool("themeData");
    isDark = phoneDark ?? true;
    notifyListeners();
  }

  void changeToDark(bool isDark) async {
    this.isDark = isDark;
    //随着新值的变化，我们创建一个监听器
    //如果发生了值的改变，就会通知各widget
    final perfs = await SharedPreferences.getInstance();
    await perfs.setBool("themeData", isDark);
    notifyListeners();
  }
}

//页面基本信息提供者
class PageDataProvider extends ChangeNotifier {
  Map<int, String> pageDatas;
  int selectedIndex;
  PageDataProvider({
    this.pageDatas = const {
      0: "Vent Roar",
      1: "发泄墙",
      2: "信息列表",
      3: "用户个人",
    },
    this.selectedIndex = 0,
  });

  void changePageIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
