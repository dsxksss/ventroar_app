import 'package:flutter/material.dart';
import './vcolors.dart';

class VDrawer extends StatefulWidget {
  final List<VoidCallback> onTap;
  const VDrawer({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  State<VDrawer> createState() => _VDrawerState();
}

class _VDrawerState extends State<VDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: VColors().vBg100,
      child: ListView(children: [
        DrawerHeader(
            child: Text(
          "I am drawer header",
          style: TextStyle(color: VColors().vPtext),
        )),
        ListTile(
          title: Text(
            "Home",
            style: TextStyle(color: VColors().vPtext),
          ),
          onTap: widget.onTap[0],
        ),
        ListTile(
          title: Text(
            "User",
            style: TextStyle(color: VColors().vPtext),
          ),
          onTap: widget.onTap[1],
        ),
        ListTile(
          title: Text(
            "Login",
            style: TextStyle(color: VColors().vPtext),
          ),
          onTap: widget.onTap[2],
        ),
      ]),
    );
  }
}
