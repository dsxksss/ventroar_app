import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ventroar_app/contexts/global_provider.dart';
import 'package:ventroar_app/page_routers.dart';
import 'package:ventroar_app/pages/pages_appbar/home_appbar.dart';
import 'package:ventroar_app/pages/pages_appbar/star_appbar.dart';
import 'package:ventroar_app/pages/pages_appbar/user_appbar.dart';
import 'package:ventroar_app/pages/user_page.dart';
import './themes/dark_theme.dart';
import './themes/light_theme.dart';
import './pages/home_page.dart';
import './pages/star_page.dart';
import './pages/chatlist_page.dart';
import 'global/widgets/drawer.dart';
import 'global/widgets/ventroar_bottom_bar.dart';
import 'pages/pages_appbar/chat_appbar.dart';
import 'schemas/user.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late Box<User> box;
  late User? _user;

  @override
  void initState() {
    super.initState();
    box = Hive.box("userbox");
    getUserData();
  }

  void getUserData() {
    _user = box.get("my");
  }

  @override
  Widget build(BuildContext context) {
    bool _isDark = Provider.of<ThemeProvider>(context).isDark;
    return MaterialApp(
      /// 主题模式切换
      themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,
      theme: lightTheme(context),
      darkTheme: darkTheme(context),
      debugShowCheckedModeBanner: false,
      initialRoute: _user != null ? "/" : "/login",
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
      const HomeAppBar(),
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

    return Builder(builder: (context) {
      return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: Scaffold(
            appBar: _appBars[_selectedIndex],

            //侧边导航栏手势打开宽度
            drawerEdgeDragWidth: _drawerEdgeDragWidth[_selectedIndex],

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
          ));
    });
  }
}
