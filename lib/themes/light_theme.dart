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
      backgroundColor: VLightThemeColors.appBarColors["bg"],
      foregroundColor: VLightThemeColors.appBarColors["foregroundColor"],
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: VColors.vSblue,
      foregroundColor: VColors.vPtext,
    ),
    iconTheme: IconThemeData(
      color: VLightThemeColors.iconColor,
    ),
    canvasColor: VLightThemeColors.pageBG,
    backgroundColor: VLightThemeColors.pageBG,
    drawerTheme: DrawerThemeData(
      backgroundColor: VLightThemeColors.drawerColors["bg"],
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 0,
      selectedItemColor: VLightThemeColors.bottomNavColors["selectedItemColor"],
      unselectedItemColor:
          VLightThemeColors.bottomNavColors["unselectedItemColor"],
      backgroundColor: VLightThemeColors.bottomNavColors["bg"],
      selectedIconTheme: null,
      unselectedIconTheme: null,
      selectedLabelStyle: null,
    ),
    listTileTheme: ListTileThemeData(
      tileColor: VColors.vStext,
    ),
  );
}
