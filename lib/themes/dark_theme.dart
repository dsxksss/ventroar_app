import 'package:flutter/material.dart';
import './vcolors.dart';

//夜间模式主题
ThemeData darkTheme(BuildContext context) {
  final base = ThemeData.dark();
  return base.copyWith(
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(
          color: VColors.vPtext, fontSize: 22, fontWeight: FontWeight.bold),
      backgroundColor: VColors.vBg100,
      foregroundColor: VColors.vPtext,
      shadowColor: VColors.vShadow,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: const Color.fromARGB(148, 0, 174, 243),
      foregroundColor: VColors.vPtext,
    ),
    iconTheme: IconThemeData(
      color: VColors.vPtext,
    ),
    backgroundColor: VColors.vBg90,
    drawerTheme: DrawerThemeData(
      backgroundColor: VColors.vBg100,
    ),
    listTileTheme: ListTileThemeData(
      tileColor: VColors.vBg100,
    ),
  );
}
