import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import '../contexts/global_provider.dart';

class WaitAnimation extends StatefulWidget {
  const WaitAnimation({Key? key, required this.height, required this.width})
      : super(key: key);
  final double height;
  final double width;
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
              width: widget.width,
              height: widget.height,
              child: const RiveAnimation.asset(
                  'static/animations/dark/wait_d.riv'),
            )
          : SizedBox(
              width: widget.width,
              height: widget.height,
              child: const RiveAnimation.asset(
                  'static/animations/light/wait_l.riv'),
            ),
    );
  }
}
