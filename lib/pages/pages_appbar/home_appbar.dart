import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
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
    return AppBar(
      backgroundColor: Theme.of(context).canvasColor,
      centerTitle: true,
      title: Text(
        "${pageDatas[selectedIndex]}",
        style: GoogleFonts.ubuntu(),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ),
      ],
    );
  }
}
