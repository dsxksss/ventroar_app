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
  double titleTextSize = 20;
  @override
  Widget build(BuildContext context) {
    Function changePageIndex =
        Provider.of<PageDataProvider>(context, listen: false).changePageIndex;
    int selectedIndex = Provider.of<PageDataProvider>(context).selectedIndex;
    Map pageDatas = Provider.of<PageDataProvider>(context).pageDatas;
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(0, 55, 0, 0),
        children: <Widget>[
          const DHeader(),
          const Divider(
            color: Colors.grey,
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Column(
              children: const [
                ListTile(
                  leading: Icon(FontAwesomeIcons.horse),
                  title: Text("title"),
                ),
                ListTile(
                  leading: Icon(FontAwesomeIcons.horse),
                  title: Text("title"),
                ),
                ListTile(
                  leading: Icon(FontAwesomeIcons.horse),
                  title: Text("title"),
                ),
                ListTile(
                  leading: Icon(FontAwesomeIcons.horse),
                  title: Text("title"),
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
                  fontSize: 21,
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
                  fontSize: 14,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 2,
            right: 16,
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
