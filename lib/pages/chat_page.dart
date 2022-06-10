import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ventroar_app/pages/userDetail_page.dart';

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
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => UserDetailPage(
                      titleText: widget.titleText,
                    ),
                  ),
                );
              },
              icon: const Icon(
                FontAwesomeIcons.ellipsisVertical,
                size: 22,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        color: Theme.of(context).backgroundColor,
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: Text(
            widget.titleText,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
