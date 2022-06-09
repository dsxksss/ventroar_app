import 'package:flutter/material.dart';
import './vcolors.dart';

//夜间模式主题
ThemeData darkTheme(BuildContext context) {
  final base = ThemeData.dark();
  return base.copyWith(
    appBarTheme: AppBarTheme(
      elevation: 0,
      titleTextStyle: TextStyle(
          color: VColors.vPtext, fontSize: 22, fontWeight: FontWeight.bold),
      backgroundColor: VColors.vBg100,
      foregroundColor: VColors.vPtext,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: const Color.fromARGB(148, 0, 174, 243),
      foregroundColor: VColors.vPtext,
    ),
    iconTheme: IconThemeData(
      color: VColors.vPtext,
    ),
    canvasColor: VColors.vBg90,
    backgroundColor: VColors.vBg90,
    drawerTheme: DrawerThemeData(
      backgroundColor: VColors.vBg100,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 0,
      selectedItemColor: VColors.vBg80,
      unselectedItemColor: VColors.vPtext,
      backgroundColor: VColors.vBg100,
      selectedIconTheme: null,
      unselectedIconTheme: null,
      selectedLabelStyle: null,
    ),
    listTileTheme: ListTileThemeData(
      tileColor: VColors.vBg100,
    ),
  );
}
