import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import '../contexts/global_provider.dart';

class SearchAnimation extends StatefulWidget {
  const SearchAnimation(
      {Key? key, required this.height, required this.width, this.onPressed})
      : super(key: key);
  final double height;
  final double width;
  final VoidCallback? onPressed;

  @override
  State<SearchAnimation> createState() => _SearchAnimationState();
}

class _SearchAnimationState extends State<SearchAnimation> {
  @override
  Widget build(BuildContext context) {
    bool _isDark = Provider.of<ThemeProvider>(context, listen: true).isDark;

    return GestureDetector(
      onTap: widget.onPressed,
      child: Center(
        child: _isDark
            ? Container(
                color: Theme.of(context)
                    .appBarTheme
                    .foregroundColor!
                    .withOpacity(0),
                width: widget.width,
                height: widget.height,
                child: const RiveAnimation.asset(
                    "static/animations/dark/search_d.riv"),
              )
            : SizedBox(
                width: widget.width,
                height: widget.height,
                child: const RiveAnimation.asset(
                    "static/animations/light/search_l.riv"),
              ),
      ),
    );
  }
}
