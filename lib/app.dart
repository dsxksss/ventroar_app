import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
      /// 后续会用到的主题模式切换
      // themeMode: ThemeMode.light,
      // theme: _lightTheme,
      // darkTheme: _lightTheme,
      themeMode: changeToDark ? ThemeMode.dark : ThemeMode.light,
      theme: changeToDark ? ThemeData.dark() : ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: VColors.vBg100,
          foregroundColor: VColors.vPtext,
          shadowColor: VColors.vShadow,
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
          duration: const Duration(milliseconds: 800),
          transitionBuilder: (
            child,
            animation,
            secondaryAnimation,
          ) {
            return FadeThroughTransition(
              //背景色
              fillColor: VColors.vBg90,
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
            index: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          );
        }),
        floatingActionButton: FloatingActionButton(
          backgroundColor: VColors.vBg80,
          child: FaIcon(
            Icons.edit,
            color: VColors.vPtext,
          ),
          onPressed: () {
            setState(() {});
          },
        ),
      ),
    );
  }
}