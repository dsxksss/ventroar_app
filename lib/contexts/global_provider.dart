import 'package:flutter/material.dart';

//昼夜主题值:isDark提供者
class ThemeProvider extends ChangeNotifier {
  bool isDark;
  ThemeProvider({this.isDark = false});
  void changeToDark(bool isDark) {
    this.isDark = isDark;
    //随着新值的变化，我们创建一个监听器
    //如果发生了值的改变，就会通知各widget
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

//用户登录状态信息提供者
class UserVerificationProvider extends ChangeNotifier {
  bool isLoginState;
  UserVerificationProvider({this.isLoginState = false});

  void changeLoginState(bool loginState) {
    isLoginState = loginState;
    notifyListeners();
  }
}
