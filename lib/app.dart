import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import './functions/vent_snack.dart';
import './ventroar_bottom_bar.dart';
import './drawer.dart';
import './themes/dark_theme.dart';
import './themes/light_theme.dart';
import './pages/home_page.dart';
import './pages/star_page.dart';
import './pages/chatlist_page.dart';
import './pages/login_page.dart';
import 'themes/vcolors.dart';
import './vappbar.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _selectedIndex = 0;
  bool changeToDark = false;
  final List<Widget> _pages = [
    const HomePage(),
    const StarPage(),
    const ChatListPage(),
    const LoginPage(),
  ];

  String? getPageName(index) {
    switch (index) {
      case 0:
        {
          return "APP主页";
        }
      case 1:
        {
          return "星墙页面";
        }
      case 2:
        {
          return "聊天列表";
        }
      case 3:
        {
          return "登录页面";
        }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /// 主题模式切换
      themeMode: changeToDark ? ThemeMode.dark : ThemeMode.light,
      theme: lightTheme(context),
      darkTheme: darkTheme(context),

      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: VAppBar(
          changeToDark: changeToDark,
          onPressed: () {
            setState(() {
              _selectedIndex = 2;
            });
          },
        ),

        //侧边导航栏手势打开宽度
        drawerEdgeDragWidth: 150.0,

        /// PageView是用来制作切换页面的组件
        /// 类似于制作翻页页面的东西
        // PageView(
        //   /// 改变切换模式
        //   // scrollDirection: Axis.vertical,
        //   children: [..._pages],
        //   clipBehavior: Clip.antiAliasWithSaveLayer,
        // ),
        ///SafeArea是自动检测屏幕高度，给定正常显示页面的widget
        body: PageTransitionSwitcher(
          duration: const Duration(milliseconds: 700),
          transitionBuilder: (
            child,
            animation,
            secondaryAnimation,
          ) {
            return FadeThroughTransition(
              //背景色
              fillColor: changeToDark ? VColors.vBg90 : Colors.white54,
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              child: child,
            );
          },
          child: _pages[_selectedIndex],
        ),

        drawer: Builder(builder: (context) {
          return VDrawer(
            index: _selectedIndex,
            onTap: [
              () {
                setState(() {
                  _selectedIndex = 0;
                });
                Navigator.pop(context);
              },
              () {
                setState(() {
                  _selectedIndex = 1;
                });
                Navigator.pop(context);
              },
              () {
                setState(() {
                  _selectedIndex = 2;
                });
                Navigator.pop(context);
              },
              () {
                setState(() {
                  _selectedIndex = 3;
                });
                Navigator.pop(context);
              },
            ],
          );
        }),
        bottomNavigationBar: Builder(builder: (context) {
          return VentRoarButtonBar(
            changeToDark: changeToDark,
            index: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
              vSnackBar(
                key: GlobalKey(),
                context: context,
                textWidget: Text(
                  getPageName(index) ?? "页面读取错误",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                showTime: const Duration(seconds: 2),
              );
            },
          );
        }),
        floatingActionButton: FloatingActionButton(
          child: FaIcon(changeToDark
              ? FontAwesomeIcons.cloudSun
              : FontAwesomeIcons.cloudMoon),
          onPressed: () {
            setState(() {
              changeToDark = !changeToDark;
            });
          },
        ),
      ),
    );
  }
}
