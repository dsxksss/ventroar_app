import 'package:flutter/material.dart';
import 'package:ventroar_app/schemas/message.dart';

class MessageBubble extends StatefulWidget {
  final Message message;
  const MessageBubble({Key? key, required this.message}) : super(key: key);

  @override
  State<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.message.isSentByMe
          ? Alignment.centerRight
          : Alignment.bottomLeft,
      child: Card(
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Text(widget.message.text),
        ),
      ),
    );
  }
}
