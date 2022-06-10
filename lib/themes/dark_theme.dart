import 'package:flutter/material.dart';
import './vcolors.dart';

//夜间模式主题
ThemeData darkTheme(BuildContext context) {
  final base = ThemeData.dark();
  return base.copyWith(
    appBarTheme: AppBarTheme(
      elevation: 0,
      titleTextStyle: TextStyle(
          color: VColors.vPtext, fontSize: 20, fontWeight: FontWeight.bold),
      backgroundColor: VDarkThemeColors.appBarColors["bg"],
      foregroundColor: VDarkThemeColors.appBarColors["foregroundColor"],
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: const Color.fromARGB(148, 0, 174, 243),
      foregroundColor: VColors.vPtext,
    ),
    iconTheme: IconThemeData(
      color: VDarkThemeColors.iconColor,
    ),
    canvasColor: VDarkThemeColors.pageBG,
    backgroundColor: VDarkThemeColors.pageBG,
    drawerTheme: DrawerThemeData(
      backgroundColor: VDarkThemeColors.drawerColors["bg"],
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 0,
      selectedItemColor: VDarkThemeColors.bottomNavColors["selectedItemColor"],
      unselectedItemColor:
          VDarkThemeColors.bottomNavColors["unselectedItemColor"],
      backgroundColor: VDarkThemeColors.bottomNavColors["bg"],
      selectedIconTheme: null,
      unselectedIconTheme: null,
      selectedLabelStyle: null,
    ),
    listTileTheme: ListTileThemeData(
      tileColor: VColors.vBg100,
    ),
  );
}
