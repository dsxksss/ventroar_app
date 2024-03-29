import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:ventroar_app/contexts/global_provider.dart';
import 'widgets/avatar_widget.dart';
import '../schemas/user.dart';

class DHeader extends StatefulWidget {
  const DHeader({
    Key? key,
  }) : super(key: key);

  @override
  State<DHeader> createState() => _DHeaderState();
}

class _DHeaderState extends State<DHeader> {
  late Box<User> box;
  @override
  void initState() {
    super.initState();
    box = Hive.box("userbox");
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.04.sw, 0.08.sh, 0, 0.02.sh),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 80.w,
              height: 80.w,
              child: AvatarWidget(
                fontSize: 30.sp,
                avatarUrl: box.get("my")?.avatarUrl ?? "null",
                userName: box.get("my")?.name ?? "null",
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
              width: 0.45.sw,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 0.015.sh),
                  Text(
                    box.get("my")?.name ?? "null",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: 0.01.sh),
                  Text(
                    box.get("my")?.email ?? "null",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class VDrawer extends StatefulWidget {
  const VDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<VDrawer> createState() => _VDrawerState();
}

class _VDrawerState extends State<VDrawer> {
  @override
  Widget build(BuildContext context) {
    Box<User> box = Hive.box("userbox");
    TextStyle _titleTextStyle = TextStyle(
      fontSize: 16.sp,
    );

    double _iconSize = 26.sp;

    Function _changePageIndex =
        Provider.of<PageDataProvider>(context, listen: false).changePageIndex;
    int _selectedIndex = Provider.of<PageDataProvider>(context).selectedIndex;
    Map _pageDatas = Provider.of<PageDataProvider>(context).pageDatas;
    bool _isDark = Provider.of<ThemeProvider>(context).isDark;

    List<Widget> _listTiles = [
      ListTile(
        minVerticalPadding: 0,
        minLeadingWidth: 0,
        contentPadding: EdgeInsets.fromLTRB(0.05.sw, 0, 0, 0),
        leading: Icon(
          _selectedIndex == 0 ? Icons.home : Icons.home_outlined,
          size: _iconSize,
        ),
        title: Text(
          _pageDatas[0],
          style: _titleTextStyle,
        ),
        onTap: () {
          _changePageIndex(0);
          Navigator.of(context).pop();
        },
        selected: _selectedIndex == 0 ? true : false,
      ),
      ListTile(
        minVerticalPadding: 0,
        minLeadingWidth: 0,
        contentPadding: EdgeInsets.fromLTRB(0.05.sw, 0, 0, 0),
        leading: Icon(
          _selectedIndex == 1 ? Icons.star_rounded : Icons.star_border_outlined,
          size: _iconSize,
        ),
        title: Text(
          _pageDatas[1],
          style: _titleTextStyle,
        ),
        onTap: () {
          _changePageIndex(1);
          Navigator.of(context).pop();
        },
        selected: _selectedIndex == 1 ? true : false,
      ),
      ListTile(
        minVerticalPadding: 0,
        minLeadingWidth: 0,
        contentPadding: EdgeInsets.fromLTRB(0.05.sw, 0, 0, 0),
        leading: Icon(
          _selectedIndex == 2
              ? Icons.text_snippet_rounded
              : Icons.text_snippet_outlined,
          size: _iconSize,
        ),
        title: Text(
          _pageDatas[2],
          style: _titleTextStyle,
        ),
        onTap: () {
          _changePageIndex(2);
          Navigator.of(context).pop();
        },
        selected: _selectedIndex == 2 ? true : false,
      ),
      ListTile(
        minVerticalPadding: 0,
        minLeadingWidth: 0,
        contentPadding: EdgeInsets.fromLTRB(0.05.sw, 0, 0, 0),
        leading: Icon(
          _selectedIndex == 3 ? Icons.person : Icons.person_outline,
          size: _iconSize,
        ),
        title: Text(
          _pageDatas[3],
          style: _titleTextStyle,
        ),
        onTap: () {
          _changePageIndex(3);
          Navigator.of(context).pop();
        },
        selected: _selectedIndex == 3 ? true : false,
      ),
    ];

    return Drawer(
      width: 0.75.sw,
      child: Column(
        children: [
          const DHeader(),
          ..._listTiles,
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Positioned(
                  bottom: 29.h,
                  left: 10.w,
                  child: TextButton.icon(
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            "/loginPage", (route) => false);
                        box.delete("my");
                      },
                      icon: Icon(
                        Icons.output,
                        color: Colors.redAccent,
                        size: 32.sp,
                      ),
                      label: Text(
                        "退出登录",
                        style: TextStyle(
                          color: Theme.of(context).textTheme.headline1!.color,
                        ),
                      )),
                ),
                Positioned(
                  bottom: 30.h,
                  right: 22.w,
                  child: IconButton(
                    onPressed: () {
                      Provider.of<ThemeProvider>(context, listen: false)
                          .changeToDark(!_isDark);
                    },
                    tooltip: "切换主题",
                    icon: Icon(
                      _isDark
                          ? FontAwesomeIcons.cloudSun
                          : FontAwesomeIcons.cloudMoon,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
