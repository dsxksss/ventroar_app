import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final BuildContext context;
  final String titleText;
  const ChatPage({Key? key, required this.titleText, required this.context})
      : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.titleText),
      ),
      body: Container(
        color: Theme.of(context).backgroundColor,
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: Text(
            widget.titleText,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
