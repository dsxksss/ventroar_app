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
        color: Colors.white,
      ),
      //背景色
      backgroundColor: VColors.black2,
      //前景色
      foregroundColor: Colors.white,
    ),

    //悬浮按钮样式
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      //背景色
      backgroundColor: Color.fromARGB(255, 2, 114, 159),
      //前景色
      foregroundColor: Colors.white,
    ),

    //icon图标样式
    iconTheme: const IconThemeData(
      //图标色
      color: Colors.white,
    ),

    //画布色
    canvasColor: VColors.black2,
    //背景色
    backgroundColor: VColors.black2,
    //水波色
    splashColor: VColors.black3,
    //高亮项内容色
    highlightColor: Colors.white.withOpacity(0),

    //侧边导航栏样式
    drawerTheme: DrawerThemeData(
      //背景色
      backgroundColor: VColors.black2,
      //模态幕布色
      // scrimColor: Colors.red,
    ),

    //底部导航栏样式
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      //景深或阴影深度
      elevation: 0,
      //选中色
      selectedItemColor: Colors.white,
      //未选中色
      unselectedItemColor: VColors.black3,
      //背景色
      backgroundColor: VColors.black1,
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
      headline1: TextStyle(color: Colors.white, fontSize: 26.sp),
      //2号标题字样式
      headline2: TextStyle(color: Colors.white, fontSize: 24.sp),
      //3号标题字样式
      headline3: TextStyle(color: Colors.white, fontSize: 22.sp),
      //4号标题字样式
      headline4: TextStyle(color: Colors.white, fontSize: 20.sp),
      //5号标题字样式
      headline5: TextStyle(color: Colors.white, fontSize: 18.sp),
      //6号标题字样式
      headline6: TextStyle(color: Colors.white, fontSize: 16.sp),
      //1号副标题字样式
      subtitle1: TextStyle(color: Colors.grey.shade400, fontSize: 18.sp),
      //2号副标题字样式
      subtitle2: TextStyle(color: Colors.grey.shade400, fontSize: 16.sp),
      //1号内容字样式
      bodyText1: TextStyle(color: Colors.white, fontSize: 13.sp),
      //2号内容字样式
      bodyText2: TextStyle(color: Colors.white, fontSize: 13.sp),
      //说明文字样式
      caption: TextStyle(color: Colors.white, fontSize: 13.sp),
      //按钮字体样式
      button: TextStyle(color: Colors.white, fontSize: 13.sp),
      //字体划线样式
      overline: TextStyle(color: Colors.white, fontSize: 13.sp),
    ),

    //tile样式
    listTileTheme: ListTileThemeData(
      //tile内容背景色
      tileColor: VColors.black2,
      //tile图标色
      iconColor: Colors.white,
      //tile文字色
      textColor: Colors.white,
      //tile被选中色
      selectedColor: const Color.fromARGB(255, 56, 128, 255),
      //tile内容被选中色
      selectedTileColor: const Color.fromARGB(79, 56, 129, 255),
    ),
  );
}
