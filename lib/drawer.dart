import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';
import 'package:ventroar_app/contexts/global_provider.dart';
import 'package:ventroar_app/widgets/vent_button.dart';

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
          const Divider(
            color: Colors.grey,
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Column(
              children: [
                ..._listTiles,
                const Divider(
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 350,
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 8,
                        left: 10,
                        child: VTextIconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.output,
                            color: Colors.redAccent,
                            size: 32,
                          ),
                          buttonText: "退出登录",
                          buttonType: GFButtonType.transparent,
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: IconButton(
                          onPressed: () {
                            Provider.of<ThemeProvider>(context, listen: false)
                                .changeToDark(!_isDark);
                          },
                          splashColor: Colors.white.withOpacity(0),
                          hoverColor: Colors.white.withOpacity(0),
                          focusColor: Colors.white.withOpacity(0),
                          disabledColor: Colors.white.withOpacity(0),
                          highlightColor: Colors.white.withOpacity(0),
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
      padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset("images/t2.png"),
            ),
          ),
          Positioned(
            top: 10,
            right: 25,
            child: Text(
              _userName,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            top: 45,
            right: 25,
            child: Text(
              _uesrEmail,
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
