import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:provider/provider.dart';
import 'package:ventroar_app/contexts/global_provider.dart';
import 'package:ventroar_app/pages/login_page.dart';
import 'package:ventroar_app/pages/pages_appbar/home_appbar.dart';
import 'package:ventroar_app/pages/pages_appbar/star_appbar.dart';
import 'package:ventroar_app/pages/pages_appbar/user_appbar.dart';
import 'package:ventroar_app/pages/user_page.dart';
import './ventroar_bottom_bar.dart';
import './drawer.dart';
import './themes/dark_theme.dart';
import './themes/light_theme.dart';
import './pages/home_page.dart';
import './pages/star_page.dart';
import './pages/chatlist_page.dart';
import 'pages/pages_appbar/chat_appbar.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final List<Widget> _pages = [
    const HomePage(),
    const StarPage(),
    const ChatListPage(),
    const UserPage(),
  ];

  @override
  Widget build(BuildContext context) {
    int _selectedIndex = Provider.of<PageDataProvider>(context).selectedIndex;
    bool _isDark = Provider.of<ThemeProvider>(context).isDark;
    bool _isLoginState =
        Provider.of<UserVerificationProvider>(context).isLoginState;

    return MaterialApp(
      /// 主题模式切换
      themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,
      theme: lightTheme(context),
      darkTheme: darkTheme(context),
      debugShowCheckedModeBanner: false,
      initialRoute: _isLoginState ? "./" : "./login",
      routes: {
        "./": (context) => AppPage(
              selectedIndex: _selectedIndex,
              pages: _pages,
            ),
        "./login": (context) => const LoginPage(),
      },
    );
  }
}

class AppPage extends StatelessWidget {
  const AppPage({
    Key? key,
    required int selectedIndex,
    required List<Widget> pages,
  })  : _selectedIndex = selectedIndex,
        _pages = pages,
        super(key: key);

  final int _selectedIndex;

  final List<Widget> _pages;

  @override
  Widget build(BuildContext context) {
    //获取每页对应的appbar
    PreferredSizeWidget? getAppBar(int selectedIndex) {
      switch (selectedIndex) {
        case 0:
          return const HomeAppBar();
        case 1:
          return const StarAppBar();
        case 2:
          return const ChatAppBar();
        case 3:
          return const UserAppBar();
      }
      return AppBar(
        title: const Text("未初始化的导航栏"),
      );
    }

//获取每页对应的侧滑触发drawer宽度
    double? getDrawerEdgeDragWidth(int selectedIndex) {
      switch (selectedIndex) {
        case 0:
          return 150.0;
        case 1:
          return 150.0;
        case 2:
          return 55.0;
        case 3:
          return 150.0;
      }
      return 0;
    }

    return Scaffold(
      appBar: getAppBar(_selectedIndex),

      //侧边导航栏手势打开宽度
      drawerEdgeDragWidth: getDrawerEdgeDragWidth(_selectedIndex),

      body: PageTransitionSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (
          child,
          animation,
          secondaryAnimation,
        ) {
          return FadeThroughTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          );
        },
        child: _pages[_selectedIndex],
      ),

      drawer: const VDrawer(),

      bottomNavigationBar: Builder(
        builder: (context) {
          return const VentRoarButtonBar();
        },
      ),
    );
  }
}
