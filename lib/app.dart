import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ventroar_app/ventroar_button_bar.dart';
import './drawer.dart';
import './home_page.dart';
import './user_page.dart';
import './login_page.dart';
import './vcolors.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _selectedIndex = 0;
  bool changeToDark = true;
  final List<Widget> _pages = [
    const HomePage(),
    const UserPage(),
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
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Vent Roar",
          ),
        ),

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
          child: FaIcon(
              changeToDark ? FontAwesomeIcons.sun : FontAwesomeIcons.moon),
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
      backgroundColor: VColors.vBg100,
      foregroundColor: VColors.vPtext,
      shadowColor: VColors.vShadow,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: VColors.vBg80,
      foregroundColor: Colors.white,
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
      backgroundColor: VColors.vPtext,
      foregroundColor: VColors.vBg100,
      shadowColor: VColors.vStext,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color.fromARGB(255, 0, 174, 243),
      foregroundColor: Colors.white,
    ),
    iconTheme: IconThemeData(
      color: VColors.vPtext,
    ),
    shadowColor: Colors.black54,
  );
}
