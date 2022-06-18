import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:ventroar_app/contexts/global_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    bool _isDark = Provider.of<ThemeProvider>(context, listen: true).isDark;
    return Center(
      child: _isDark
          ? Container(
              color:
                  Theme.of(context).appBarTheme.foregroundColor!.withOpacity(0),
              width: 200,
              height: 200,
              child: const RiveAnimation.asset(
                  'static/animations/dark/whit_d.riv'),
            )
          : const SizedBox(
              width: 200,
              height: 200,
              child: RiveAnimation.asset('static/animations/light/whit_l.riv'),
            ),
    );
  }
}
