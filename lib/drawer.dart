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
    TextStyle _titleTextStyle = TextStyle(
        fontSize: 18,
        color: Theme.of(context).appBarTheme.titleTextStyle!.color);

    double _iconSize = 30;

    Function _changePageIndex =
        Provider.of<PageDataProvider>(context, listen: false).changePageIndex;

    int _selectedIndex = Provider.of<PageDataProvider>(context).selectedIndex;

    Map _pageDatas = Provider.of<PageDataProvider>(context).pageDatas;

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
        selectedColor: const Color.fromARGB(255, 56, 128, 255),
        selectedTileColor: const Color.fromARGB(79, 56, 129, 255),
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
        selectedColor: const Color.fromARGB(255, 56, 128, 255),
        selectedTileColor: const Color.fromARGB(79, 56, 129, 255),
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
        selectedColor: const Color.fromARGB(255, 56, 128, 255),
        selectedTileColor: const Color.fromARGB(79, 56, 129, 255),
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
        selectedColor: const Color.fromARGB(255, 56, 128, 255),
        selectedTileColor: const Color.fromARGB(79, 56, 129, 255),
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
    bool _isDark = Provider.of<ThemeProvider>(context).isDark;
    return Container(
      height: 120,
      padding: const EdgeInsets.fromLTRB(20, 5, 2, 0),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.asset("images/t2.png"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(120, 0, 0, 0),
            child: ListTile(
              contentPadding: const EdgeInsets.all(0),
              minLeadingWidth: 0,
              title: Text(
                _userName,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(120, 35, 0, 0),
            child: ListTile(
              minLeadingWidth: 0,
              contentPadding: const EdgeInsets.all(0),
              title: Text(
                _uesrEmail,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 1,
            right: 15,
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
    );
  }
}
