import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../contexts/global_provider.dart';

//TODO:待调整文件命名规范
class StarAppBar extends StatefulWidget implements PreferredSizeWidget {
  const StarAppBar({Key? key}) : super(key: key);
  @override
  State<StarAppBar> createState() => _StarAppBarState();

  //appbar需要实现一个preferredSize接口才可以导出为widget使用
  @override
  Size get preferredSize => const Size.fromHeight(55.0);
}

class _StarAppBarState extends State<StarAppBar> {
  @override
  Widget build(BuildContext context) {
    Map pageDatas = Provider.of<PageDataProvider>(context).pageDatas;
    int selectedIndex = Provider.of<PageDataProvider>(context).selectedIndex;
    return AppBar(
      centerTitle: true,
      leading: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
        child: IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: const Icon(
            FontAwesomeIcons.barsStaggered,
            size: 20,
          ),
        ),
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).appBarTheme.backgroundColor,
        statusBarIconBrightness: context.watch<ThemeProvider>().isDark
            ? Brightness.light
            : Brightness.dark,
      ),
      title: Text("${pageDatas[selectedIndex]}"),
    );
  }
}
