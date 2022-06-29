import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './vcolors.dart';

//日间模式主题
ThemeData lightTheme(BuildContext context) {
  final base = ThemeData.light();
  return base.copyWith(
    //顶部导航栏样式
    appBarTheme: AppBarTheme(
      //景深或阴影深度
      elevation: 0,
      //顶部导航栏字体样式
      titleTextStyle: GoogleFonts.zcoolKuaiLe(
        //字粗
        fontWeight: FontWeight.w500,
        //字号
        fontSize: 22,
        //字色
        color: VColors.vBg100,
      ),
      //背景色
      backgroundColor: VLightThemeColors.appBarColors["bg"],
      //前景色
      foregroundColor: VLightThemeColors.appBarColors["foregroundColor"],
    ),

    //悬浮按钮样式
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      //背景色
      backgroundColor: VColors.vSblue,
      //前景色
      foregroundColor: VColors.vPtext,
    ),

    //icon图标样式
    iconTheme: IconThemeData(
      //图标色
      color: VLightThemeColors.iconColor,
    ),

    //画布色
    canvasColor: VLightThemeColors.pageBG,
    //背景色
    backgroundColor: VLightThemeColors.pageBG,
    //水波色
    splashColor: Colors.white.withOpacity(0),
    //高亮项内容色
    highlightColor: Colors.white.withOpacity(0),

    //侧边导航栏样式
    drawerTheme: DrawerThemeData(
      //背景色
      backgroundColor: VLightThemeColors.drawerColors["bg"],
      //模态幕布颜色
      // scrimColor: Colors.red,
    ),

    //底部导航栏样式
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      //景深或阴影深度
      elevation: 0,
      //选中色
      selectedItemColor: VLightThemeColors.bottomNavColors["selectedItemColor"],
      //未选中色
      unselectedItemColor:
          VLightThemeColors.bottomNavColors["unselectedItemColor"],
      //背景色
      backgroundColor: VLightThemeColors.bottomNavColors["bg"],
      //选中icon样式
      selectedIconTheme: null,
      //未选中icon样式
      unselectedIconTheme: null,
      //选中label样式
      selectedLabelStyle: null,
    ),

    ///全局字体设置
    textTheme: TextTheme(
      //1号标题字样式
      headline1: TextStyle(color: VColors.vBg100),
      //2号标题字样式
      headline2: TextStyle(color: VColors.vBg100),
      //3号标题字样式
      headline3: TextStyle(color: VColors.vBg100),
      //4号标题字样式
      headline4: TextStyle(color: VColors.vBg100),
      //5号标题字样式
      headline5: TextStyle(color: VColors.vBg100),
      //6号标题字样式
      headline6: TextStyle(color: VColors.vBg100),
      //1号副标题字样式
      subtitle1: TextStyle(color: VColors.vBg100),
      //2号副标题字样式
      subtitle2: TextStyle(color: VColors.vBg100),
      //1号内容字样式
      bodyText1: TextStyle(color: VColors.vBg100),
      //1号内容字样式
      bodyText2: TextStyle(color: VColors.vBg100),
      //说明文字样式
      caption: TextStyle(color: VColors.vBg100),
      //按钮字体样式
      button: TextStyle(color: VColors.vBg100),
      //字体划线样式
      overline: TextStyle(color: VColors.vBg100),
    ),

//tile样式
    listTileTheme: ListTileThemeData(
      //tile内容背景色
      tileColor: VLightThemeColors.listTileColors["tileColor"],
      //tile图标色
      iconColor: VLightThemeColors.listTileColors["iconColor"],
      //tile文字色
      textColor: VLightThemeColors.listTileColors["textColor"],
      //tile被选中色
      selectedColor: VLightThemeColors.listTileColors["selectedColor"],
      //tile内容被选中色
      selectedTileColor: VLightThemeColors.listTileColors["selectedTileColor"],
    ),
  );
}
