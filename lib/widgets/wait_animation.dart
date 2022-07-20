import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import '../contexts/global_provider.dart';

class WaitAnimation extends StatefulWidget {
  const WaitAnimation({Key? key}) : super(key: key);

  @override
  State<WaitAnimation> createState() => _WaitAnimationState();
}

class _WaitAnimationState extends State<WaitAnimation> {
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
                  'static/animations/dark/wait_d.riv'),
            )
          : const SizedBox(
              width: 200,
              height: 200,
              child: RiveAnimation.asset('static/animations/light/wait_l.riv'),
            ),
    );
  }
}
