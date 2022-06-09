import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ventroar_app/contexts/global_provider.dart';
import './ventroar_bottom_bar.dart';
import './drawer.dart';
import './themes/dark_theme.dart';
import './themes/light_theme.dart';
import './pages/home_page.dart';
import './pages/star_page.dart';
import './pages/chatlist_page.dart';
import './pages/login_page.dart';
import './vappbar.dart';

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
    const LoginPage(),
  ];

  @override
  Widget build(BuildContext context) {
    int _selectedIndex = Provider.of<PageDataProvider>(context).selectedIndex;
    bool _isDark = Provider.of<ThemeProvider>(context).isDark;
    return MaterialApp(
      /// 主题模式切换
      themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,
      theme: lightTheme(context),
      darkTheme: darkTheme(context),

      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: const VAppBar(),

        //侧边导航栏手势打开宽度
        drawerEdgeDragWidth: 150.0,

        body: PageTransitionSwitcher(
          duration: const Duration(milliseconds: 700),
          transitionBuilder: (
            child,
            animation,
            secondaryAnimation,
          ) {
            return FadeThroughTransition(
              //背景色
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              child: child,
            );
          },
          child: _pages[_selectedIndex],
        ),

        drawer: const VDrawer(),

        bottomNavigationBar: Builder(builder: (context) {
          return const VentRoarButtonBar();
        }),
        floatingActionButton: FloatingActionButton(
          child: FaIcon(
              _isDark ? FontAwesomeIcons.cloudSun : FontAwesomeIcons.cloudMoon),
          onPressed: () {
            Provider.of<ThemeProvider>(context, listen: false)
                .changeToDark(!_isDark);
          },
        ),
      ),
    );
  }
}
