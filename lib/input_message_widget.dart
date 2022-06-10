import 'package:flutter/material.dart';

class InputMessage extends StatefulWidget {
  final Function(String) onSubmitted;
  const InputMessage({Key? key, required this.onSubmitted}) : super(key: key);

  @override
  State<InputMessage> createState() => _InputMessageState();
}

class _InputMessageState extends State<InputMessage> {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(50),
          ),
        ),
        child: Row(
          children: [
            TextField(
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(12),
                hintText: "请输入点什么...",
              ),
              showCursor: false,
              onSubmitted: widget.onSubmitted,
            ),
          ],
        ),
      );
    });
  }
}
