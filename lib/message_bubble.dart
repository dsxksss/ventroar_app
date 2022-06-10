import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
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
    return Container(
      margin: widget.message.isSentByMe
          ? const EdgeInsets.fromLTRB(0, 5, 0, 5)
          : const EdgeInsets.fromLTRB(0, 15, 0, 15),
      child: BubbleSpecialThree(
        text: widget.message.text,
        color: widget.message.isSentByMe
            ? const Color(0xFF1B97F3)
            : const Color(0xFFE8E8EE),
        tail: false, //是否显示边角
        seen: false, //是否设置已读
        sent: false, //是否发送完毕
        delivered: false, //是否被选中
        isSender: widget.message.isSentByMe,
        textStyle: TextStyle(
          color: widget.message.isSentByMe ? Colors.white : Colors.black,
          fontSize: 16,
        ),
      ),
    );
  }
}
