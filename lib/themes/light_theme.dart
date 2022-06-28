import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './vcolors.dart';

//日间模式主题
ThemeData lightTheme(BuildContext context) {
  final base = ThemeData.light();
  return base.copyWith(
    appBarTheme: AppBarTheme(
      elevation: 0,
      titleTextStyle: GoogleFonts.zcoolKuaiLe(
          fontWeight: FontWeight.w500, fontSize: 22, color: VColors.vBg100),
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
    splashColor: Colors.white.withOpacity(0),
    highlightColor: Colors.white.withOpacity(0),
    drawerTheme: DrawerThemeData(
      backgroundColor: VLightThemeColors.drawerColors["bg"],
      //模态幕布颜色
      // scrimColor: Colors.red,
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
    textTheme: TextTheme(
      bodyText1: TextStyle(
        color: VColors.vBg100,
      ),
    ),
    listTileTheme: ListTileThemeData(
      tileColor: VLightThemeColors.listTileColors["tileColor"],
      iconColor: VLightThemeColors.listTileColors["iconColor"],
      textColor: VLightThemeColors.listTileColors["textColor"],
      selectedColor: VLightThemeColors.listTileColors["selectedColor"],
      selectedTileColor: VLightThemeColors.listTileColors["selectedTileColor"],
    ),
  );
}
