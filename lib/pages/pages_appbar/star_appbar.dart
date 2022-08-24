import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import '../../contexts/global_provider.dart';
import '../../global/widgets/avatars.dart';
import '../../schemas/user.dart';

List<Widget> starAppBar(BuildContext context, bool innerBoxIsScrolled) {
  Map pageDatas = Provider.of<PageDataProvider>(context).pageDatas;
  int selectedIndex = Provider.of<PageDataProvider>(context).selectedIndex;
  Box<User> box = Hive.box("userbox");
  User _user = box.get("my")!;

  return <Widget>[
    SliverAppBar(
      leading: Padding(
        padding: const EdgeInsets.fromLTRB(18.0, 10.0, 2.0, 10.0),
        child: Avatar(
          user: _user,
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),

      title: Text("${pageDatas[selectedIndex]}"),
      centerTitle: true, //标题居中
      expandedHeight: 55.0, //展开高度200
      floating: true, //不随着滑动隐藏标题
      pinned: false, //不固定在顶部
      flexibleSpace: const FlexibleSpaceBar(
        centerTitle: true,
      ),
    )
  ];
}
