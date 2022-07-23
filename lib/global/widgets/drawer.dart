import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ventroar_app/contexts/global_provider.dart';

class DHeader extends StatelessWidget {
  final String _userName = "zhangxiaokang";
  final String _userEmail = "2546650292@qq.com";
  const DHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0.23.sh,
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.06.sw, 0.02.sh, 0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.network(
                  "https://ventroar.xyz:2548/avatars/62d2a4a97f54698b299619ff--73477803.png"),
            ),
            SizedBox(height: 0.015.sh),
            Text(
              _userName,
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 0.01.sh),
            Text(_userEmail),
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
    TextStyle _titleTextStyle = TextStyle(
      fontSize: 16.sp,
    );

    double _iconSize = 26.sp;

    Function _changePageIndex =
        Provider.of<PageDataProvider>(context, listen: false).changePageIndex;

    int _selectedIndex = Provider.of<PageDataProvider>(context).selectedIndex;

    Map _pageDatas = Provider.of<PageDataProvider>(context).pageDatas;

    bool _isDark = Provider.of<ThemeProvider>(context).isDark;

    final Function _loginOut =
        Provider.of<UserVerificationProvider>(context).loginOut;

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
      child: ListView(
        children: <Widget>[
          const DHeader(),
          Container(
            padding: EdgeInsets.fromLTRB(0, 0.01.sh, 0, 0),
            child: Column(
              children: [
                ..._listTiles,
                SizedBox(
                  height: 0.77.sw,
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        left: 10,
                        child: TextButton.icon(
                            onPressed: () {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  "./login", (route) => false);
                              _loginOut();
                            },
                            icon: Icon(
                              Icons.output,
                              color: Colors.redAccent,
                              size: 32.sp,
                            ),
                            label: Text(
                              "退出登录",
                              style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .color,
                              ),
                            )),
                      ),
                      Positioned(
                        bottom: 1,
                        right: 22,
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
          ),
        ],
      ),
    );
  }
}
