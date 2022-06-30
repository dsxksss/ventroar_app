import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import './vcolors.dart';

//夜间模式主题
ThemeData darkTheme(BuildContext context) {
  final base = ThemeData.dark();
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
        color: VColors.vPtext,
      ),
      //背景色
      backgroundColor: VDarkThemeColors.appBarColors["bg"],
      //前景色
      foregroundColor: VDarkThemeColors.appBarColors["foregroundColor"],
    ),

    //悬浮按钮样式
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      //背景色
      backgroundColor: const Color.fromARGB(148, 0, 174, 243),
      //前景色
      foregroundColor: VColors.vPtext,
    ),

    //icon图标样式
    iconTheme: IconThemeData(
      //图标色
      color: VDarkThemeColors.iconColor,
    ),

    //画布色
    canvasColor: VDarkThemeColors.pageBG,
    //背景色
    backgroundColor: VDarkThemeColors.pageBG,
    //水波色
    splashColor: Colors.white.withOpacity(0),
    //高亮项内容色
    highlightColor: Colors.white.withOpacity(0),

    //侧边导航栏样式
    drawerTheme: DrawerThemeData(
      //背景色
      backgroundColor: VDarkThemeColors.drawerColors["bg"],
      //模态幕布色
      // scrimColor: Colors.red,
    ),

    //底部导航栏样式
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      //景深或阴影深度
      elevation: 0,
      //选中色
      selectedItemColor: VDarkThemeColors.bottomNavColors["selectedItemColor"],
      //未选中色
      unselectedItemColor:
          VDarkThemeColors.bottomNavColors["unselectedItemColor"],
      //背景色
      backgroundColor: VDarkThemeColors.bottomNavColors["bg"],
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
      headline1: TextStyle(color: VColors.vPtext, fontSize: 13.sp),
      //2号标题字样式
      headline2: TextStyle(color: VColors.vPtext, fontSize: 13.sp),
      //3号标题字样式
      headline3: TextStyle(color: VColors.vPtext, fontSize: 13.sp),
      //4号标题字样式
      headline4: TextStyle(color: VColors.vPtext, fontSize: 13.sp),
      //5号标题字样式
      headline5: TextStyle(color: VColors.vPtext, fontSize: 13.sp),
      //6号标题字样式
      headline6: TextStyle(color: VColors.vPtext, fontSize: 13.sp),
      //1号副标题字样式
      subtitle1: TextStyle(color: VColors.vPtext, fontSize: 13.sp),
      //2号副标题字样式
      subtitle2: TextStyle(color: VColors.vPtext, fontSize: 13.sp),
      //1号内容字样式
      bodyText1: TextStyle(color: VColors.vPtext, fontSize: 13.sp),
      //2号内容字样式
      bodyText2: TextStyle(color: VColors.vPtext, fontSize: 13.sp),
      //说明文字样式
      caption: TextStyle(color: VColors.vPtext, fontSize: 13.sp),
      //按钮字体样式
      button: TextStyle(color: VColors.vPtext, fontSize: 13.sp),
      //字体划线样式
      overline: TextStyle(color: VColors.vPtext, fontSize: 13.sp),
    ),

    //tile样式
    listTileTheme: ListTileThemeData(
      //tile内容背景色
      tileColor: VDarkThemeColors.listTileColors["tileColor"],
      //tile图标色
      iconColor: VDarkThemeColors.listTileColors["iconColor"],
      //tile文字色
      textColor: VDarkThemeColors.listTileColors["textColor"],
      //tile被选中色
      selectedColor: VDarkThemeColors.listTileColors["selectedColor"],
      //tile内容被选中色
      selectedTileColor: VDarkThemeColors.listTileColors["selectedTileColor"],
    ),
  );
}
