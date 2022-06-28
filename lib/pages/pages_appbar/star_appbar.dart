import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../contexts/global_provider.dart';

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
      title: Text("${pageDatas[selectedIndex]}"),
    );
  }
}
