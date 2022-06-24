import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginAppBar extends StatefulWidget implements PreferredSizeWidget {
  const LoginAppBar({Key? key}) : super(key: key);
  @override
  State<LoginAppBar> createState() => _LoginAppBarState();

  //appbar需要实现一个preferredSize接口才可以导出为widget使用
  @override
  Size get preferredSize => const Size.fromHeight(55.0);
}

class _LoginAppBarState extends State<LoginAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Text(
        "登入VentRoar",
        style: GoogleFonts.ubuntu(),
      ),
    );
  }
}
