import 'package:flutter/material.dart';

class ChatFloatButton extends StatelessWidget {
  const ChatFloatButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      splashColor: Colors.transparent,
      onPressed: () {},
      child: const Icon(Icons.email),
    );
  }
}
