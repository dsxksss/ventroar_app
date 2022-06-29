import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ventroar_app/contexts/global_provider.dart';

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
    TextStyle _titleTextStyle = const TextStyle(
      fontSize: 18,
    );

    double _iconSize = 30;

    Function _changePageIndex =
        Provider.of<PageDataProvider>(context, listen: false).changePageIndex;

    int _selectedIndex = Provider.of<PageDataProvider>(context).selectedIndex;

    Map _pageDatas = Provider.of<PageDataProvider>(context).pageDatas;

    bool _isDark = Provider.of<ThemeProvider>(context).isDark;

    List<Widget> _listTiles = [
      ListTile(
        minVerticalPadding: 0,
        minLeadingWidth: 0,
        contentPadding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
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
        contentPadding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
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
        contentPadding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
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
        contentPadding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
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
        padding: const EdgeInsets.fromLTRB(0, 55, 0, 0),
        children: <Widget>[
          const DHeader(),
          Container(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Column(
              children: [
                ..._listTiles,
                SizedBox(
                  height: 370,
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        left: 10,
                        child: TextButton.icon(
                            onPressed: () {
                              Navigator.of(context).pushNamed("./login");
                            },
                            icon: const Icon(
                              Icons.output,
                              color: Colors.redAccent,
                              size: 32,
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

class DHeader extends StatelessWidget {
  final String _userName = "zhangxiaokang";
  final String _uesrEmail = "2546650292@qq.com";
  const DHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      padding: const EdgeInsets.fromLTRB(10, 15, 0, 0),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(2, 0, 0, 0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset("static/img/t2.png"),
            ),
          ),
          Positioned(
            top: 10,
            right: 25,
            child: Text(
              _userName,
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodyText1!.color!),
            ),
          ),
          Positioned(
            top: 45,
            right: 25,
            child: Text(
              _uesrEmail,
              style: TextStyle(
                  fontSize: 15,
                  color: Theme.of(context).textTheme.bodyText1!.color!),
            ),
          ),
        ],
      ),
    );
  }
}
