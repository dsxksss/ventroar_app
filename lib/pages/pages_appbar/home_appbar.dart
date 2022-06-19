import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import '../../contexts/global_provider.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  const HomeAppBar({Key? key}) : super(key: key);
  @override
  State<HomeAppBar> createState() => _HomeAppBarState();

  //appbar需要实现一个preferredSize接口才可以导出为widget使用
  @override
  Size get preferredSize => const Size.fromHeight(55.0);
}

class _HomeAppBarState extends State<HomeAppBar> {
  @override
  Widget build(BuildContext context) {
    Map pageDatas = Provider.of<PageDataProvider>(context).pageDatas;
    int selectedIndex = Provider.of<PageDataProvider>(context).selectedIndex;
    bool _isDark = Provider.of<ThemeProvider>(context, listen: true).isDark;
    return AppBar(
      backgroundColor: Theme.of(context).canvasColor,
      centerTitle: true,
      title: Text(
        "${pageDatas[selectedIndex]}",
        style: GoogleFonts.ubuntu(fontSize: 21, fontWeight: FontWeight.w500),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 25, 0),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Scaffold(
                  appBar: AppBar(
                    centerTitle: true,
                    title: const Text("搜索"),
                  ),
                  body: Container(
                    color: Theme.of(context).canvasColor,
                    child: Center(
                      child: _isDark
                          ? Container(
                              color: Theme.of(context)
                                  .appBarTheme
                                  .foregroundColor!
                                  .withOpacity(0),
                              width: 300,
                              height: 300,
                              child: const RiveAnimation.asset(
                                  "static/animations/dark/search_d.riv"),
                            )
                          : const SizedBox(
                              width: 300,
                              height: 300,
                              child: RiveAnimation.asset(
                                  "static/animations/light/search_l.riv"),
                            ),
                    ),
                  ),
                ),
              ));
            },
            child: _isDark
                ? Container(
                    color: Theme.of(context)
                        .appBarTheme
                        .foregroundColor!
                        .withOpacity(0),
                    width: 30,
                    height: 30,
                    child: const RiveAnimation.asset(
                        "static/animations/dark/search_d.riv"),
                  )
                : const SizedBox(
                    width: 30,
                    height: 30,
                    child: RiveAnimation.asset(
                        "static/animations/light/search_l.riv"),
                  ),
          ),
        ),
      ],
    );
  }
}
