import 'package:flutter/material.dart';
import './vcolors.dart';

//日间模式主题
ThemeData lightTheme(BuildContext context) {
  final base = ThemeData.light();
  return base.copyWith(
    appBarTheme: AppBarTheme(
      elevation: 2,
      titleTextStyle: TextStyle(
          color: VColors.vBg100, fontSize: 22, fontWeight: FontWeight.bold),
      backgroundColor: VColors.vPtext,
      foregroundColor: VColors.vBg100,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: VColors.vSblue,
      foregroundColor: VColors.vPtext,
    ),
    iconTheme: IconThemeData(
      color: VColors.vPtext,
    ),
    canvasColor: VColors.vStext,
    backgroundColor: VColors.vStext,
    drawerTheme: DrawerThemeData(
      backgroundColor: VColors.vPtext,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 0,
      selectedItemColor: VColors.vSblue,
      unselectedItemColor: VColors.vPtext,
      backgroundColor: VColors.vSblue,
      selectedIconTheme: null,
      unselectedIconTheme: null,
      selectedLabelStyle: null,
    ),
    listTileTheme: ListTileThemeData(
      tileColor: VColors.vStext,
    ),
  );
}
