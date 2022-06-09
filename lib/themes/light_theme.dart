import 'package:flutter/material.dart';
import './vcolors.dart';

//日间模式主题
ThemeData lightTheme(BuildContext context) {
  final base = ThemeData.light();
  return base.copyWith(
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(
          color: VColors.vBg100, fontSize: 22, fontWeight: FontWeight.bold),
      backgroundColor: VColors.vPtext,
      foregroundColor: VColors.vBg100,
      shadowColor: VColors.vStext,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: VColors.vSblue,
      foregroundColor: VColors.vPtext,
    ),
    iconTheme: IconThemeData(
      color: VColors.vPtext,
    ),
    backgroundColor: VColors.vPtext,
    bottomAppBarTheme: BottomAppBarTheme(color: VColors.vPtext),
    listTileTheme: ListTileThemeData(
      tileColor: VColors.vStext,
    ),
  );
}
