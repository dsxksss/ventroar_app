import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ventroar_app/ventroar_bottom_bar.dart';
import './drawer.dart';
import './home_page.dart';
import './star_page.dart';
import './login_page.dart';
import './vcolors.dart';
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
    const LoginPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /// 主题模式切换
      themeMode: changeToDark ? ThemeMode.dark : ThemeMode.light,
      theme: _lightTheme(context),
      darkTheme: _darkTheme(context),

      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: VAppBar(changeToDark: changeToDark),

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

//夜间模式主题
ThemeData _darkTheme(BuildContext context) {
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
    drawerTheme: DrawerThemeData(
      backgroundColor: VColors.vBg100,
    ),
  );
}

//日间模式主题
ThemeData _lightTheme(BuildContext context) {
  final base = ThemeData.light();
  return base.copyWith(
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(
          color: VColors.vBg100, fontSize: 22, fontWeight: FontWeight.bold),
      backgroundColor: VColors.vPtext,
      foregroundColor: VColors.vBg100,
      shadowColor: VColors.vStext,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: VColors.vSblue,
      foregroundColor: VColors.vPtext,
    ),
    iconTheme: IconThemeData(
      color: VColors.vPtext,
    ),
    bottomAppBarTheme: BottomAppBarTheme(color: VColors.vPtext),
  );
}
