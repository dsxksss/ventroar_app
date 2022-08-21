import 'package:flutter/material.dart';
import 'package:ventroar_app/widgets/wait_animation.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({Key? key}) : super(key: key);

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  @override
  Widget build(BuildContext context) {
    return const WaitAnimation(
      width: 200,
      height: 200,
    );
  }
}
