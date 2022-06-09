import 'package:flutter/material.dart';

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
