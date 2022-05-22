import 'package:flutter/material.dart';

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
      child: ListView(children: [
        const DrawerHeader(
            child: Text(
          "I am drawer header",
        )),
        ListTile(
          title: const Text(
            "Home",
          ),
          onTap: widget.onTap[0],
        ),
        ListTile(
          title: const Text(
            "User",
          ),
          onTap: widget.onTap[1],
        ),
        ListTile(
          title: const Text(
            "Login",
          ),
          onTap: widget.onTap[2],
        ),
      ]),
    );
  }
}
