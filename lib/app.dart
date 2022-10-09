import 'dart:ui';

import 'package:dio/dio.dart';
import 'functions/vent_snack.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ventroar_app/page_routers.dart';
import 'package:ventroar_app/drawer.dart';
import 'package:ventroar_app/pages/user_page.dart';
import 'pages/pages_floatbutton/chat_floatbutton.dart';
import 'pages/pages_floatbutton/home_floatbutton.dart';
import 'pages/pages_floatbutton/star_floatbutton.dart';
import 'pages/pages_floatbutton/user_floatbutton.dart';
import 'package:ventroar_app/contexts/global_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ventroar_app/ventroar_bottom_bar.dart';
import 'package:ventroar_app/pages/pages_appbar/star_appbar.dart';
import 'package:ventroar_app/pages/pages_appbar/user_appbar.dart';

import './schemas/roar.dart';
import './schemas/user.dart';
import './pages/star_page.dart';
import './pages/home_page.dart';
import './themes/dark_theme.dart';
import './themes/light_theme.dart';
import './pages/chatlist_page.dart';
import './global/global_context.dart';
import './services/roar_http_lib.dart';
import './pages/pages_appbar/chat_appbar.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late Box<User> box;

  @override
  void initState() {
    super.initState();
    box = Hive.box("userbox");
  }

  @override
  Widget build(BuildContext context) {
    bool _isDark = Provider.of<ThemeProvider>(context).isDark;
    return MaterialApp(
      //全局context
      navigatorKey: NavigationService.navigatorKey,

      /// 主题模式切换
      themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,
      theme: lightTheme(context),
      darkTheme: darkTheme(context),
      debugShowCheckedModeBanner: false,
      initialRoute: "/loginPage",
      routes: pageRouter(),
    );
  }
}

class AppPage extends StatefulWidget {
  const AppPage({Key? key}) : super(key: key);

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  late Box<Roar> roarsBox;
  @override
  void initState() {
    super.initState();
    roarsBox = Hive.box("roarsbox");
    getAllRoar();
  }

  Future getAllRoar() async {
    try {
      var response = await RoarHttpLib().getAllRoarText(box: roarsBox);
      if (response["statusCode"] == 200) {}
    } on DioError catch (e) {
      vSnackBar(
        showTime: const Duration(seconds: 2),
        dismissDirection: DismissDirection.startToEnd,
        model: VSnackModel.error,
        isScroll: e.type != DioErrorType.connectTimeout && e.response != null
            ? true
            : false,
        textWidget: Text(
          e.type == DioErrorType.connectTimeout
              ? "网络超时,请检查网络重试!"
              : e.response?.data["msg"] ?? "未连接网络,请检查后重试!",
          style: TextStyle(
              fontSize: 17.sp,
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    int _selectedIndex = Provider.of<PageDataProvider>(context).selectedIndex;
    final List<Widget> _pages = [
      const HomePage(),
      const StarPage(),
      const ChatListPage(),
      const UserPage(),
    ];

    final List<PreferredSizeWidget?> _appBars = [
      null,
      const StarAppBar(),
      const ChatAppBar(),
      const UserAppBar(),
    ];

    final List<double> _drawerEdgeDragWidth = [
      150.0,
      150.0,
      55.0,
      150.0,
    ];

    final List<Widget> _floatingButtons = [
      const HomeFloatButton(),
      const StarFloatButton(),
      const ChatFloatButton(),
      const UserFloatButton(),
    ];

    //这里能获取到padding
    MediaQueryData data = MediaQueryData.fromWindow(window);
    return Builder(
      builder: (context) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            //固定字号防止后续系统设置影响
            textScaleFactor: 1.0,
            //固定原屏幕的padding
            //防止后续关闭顶部导航了
            //或者底部导航栏导致的画面抖动
            padding: data.padding,
            viewPadding: data.viewPadding,
            viewInsets: data.viewInsets,
          ),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            // extendBodyBehindAppBar: true,
            appBar: _appBars[_selectedIndex],
            //侧边导航栏手势打开宽度
            drawerEdgeDragWidth: _drawerEdgeDragWidth[_selectedIndex],
            body: Container(
              color: Theme.of(context).backgroundColor,
              child: _pages[_selectedIndex],
            ),
            floatingActionButton: _floatingButtons[_selectedIndex],
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            drawer: const VDrawer(),
            bottomNavigationBar: const VentRoarButtonBar(),
          ),
        );
      },
    );
  }
}
