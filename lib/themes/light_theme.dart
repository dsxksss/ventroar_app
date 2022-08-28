import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ventroar_app/themes/vcolors.dart';

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
        color: Colors.black,
      ),
      //背景色
      backgroundColor: Colors.white60,
      //前景色
      foregroundColor: VColors.black1,
    ),

    //悬浮按钮样式
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      //背景色
      backgroundColor: Color.fromARGB(255, 0, 174, 243),
      //前景色
      foregroundColor: Colors.white,
    ),

    //icon图标样式
    iconTheme: IconThemeData(
      //图标色
      color: VColors.black2,
    ),

    //画布色
    canvasColor: Colors.white60,
    //背景色
    backgroundColor: Colors.white60,
    //水波色
    splashColor: Colors.grey.shade300,
    //高亮项内容色
    highlightColor: Colors.white.withOpacity(0),

    //侧边导航栏样式
    drawerTheme: const DrawerThemeData(
      //背景色
      backgroundColor: Colors.white,
      //模态幕布颜色
      // scrimColor: Colors.red,
    ),

    //底部导航栏样式
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      //景深或阴影深度
      elevation: 0,
      //选中色
      selectedItemColor: Color.fromARGB(255, 230, 234, 236),
      //未选中色
      unselectedItemColor: Colors.white,
      //背景色
      backgroundColor: Color.fromRGBO(238, 243, 250, 1),
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
      headline1: TextStyle(color: Colors.black, fontSize: 13.sp),
      //2号标题字样式
      headline2: TextStyle(color: Colors.black, fontSize: 13.sp),
      //3号标题字样式
      headline3: TextStyle(color: Colors.black, fontSize: 13.sp),
      //4号标题字样式
      headline4: TextStyle(color: Colors.black, fontSize: 13.sp),
      //5号标题字样式
      headline5: TextStyle(color: Colors.black, fontSize: 13.sp),
      //6号标题字样式
      headline6: TextStyle(color: Colors.black, fontSize: 13.sp),
      //1号副标题字样式
      subtitle1: TextStyle(color: Colors.black, fontSize: 13.sp),
      //2号副标题字样式
      subtitle2: TextStyle(color: Colors.black, fontSize: 13.sp),
      //1号内容字样式
      bodyText1: TextStyle(color: Colors.black, fontSize: 13.sp),
      //1号内容字样式
      bodyText2: TextStyle(color: Colors.black, fontSize: 13.sp),
      //说明文字样式
      caption: TextStyle(color: Colors.black, fontSize: 13.sp),
      //按钮字体样式
      button: TextStyle(color: Colors.black, fontSize: 13.sp),
      //字体划线样式
      overline: TextStyle(color: Colors.black, fontSize: 13.sp),
    ),

//tile样式
    listTileTheme: const ListTileThemeData(
      //tile内容背景色
      tileColor: Colors.white60,
      //tile图标色
      iconColor: Colors.black,
      //tile文字色
      textColor: Colors.black,
      //tile被选中色
      selectedColor: Color.fromARGB(255, 56, 128, 255),
      //tile内容被选中色
      selectedTileColor: Color.fromARGB(79, 56, 129, 255),
    ),
  );
}
