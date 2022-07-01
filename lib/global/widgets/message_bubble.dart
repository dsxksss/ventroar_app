import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          ? const EdgeInsets.fromLTRB(0, 0, 0, 0)
          : const EdgeInsets.fromLTRB(0, 15, 0, 15),
      child: BubbleSpecialThree(
        text: widget.message.text,
        color: widget.message.isSentByMe
            ? const Color.fromARGB(255, 31, 148, 238)
            : const Color.fromARGB(255, 223, 223, 235),
        tail: true, //是否显示边角
        seen: false, //是否设置已读
        sent: false, //是否发送完毕
        delivered: false, //是否被选中
        isSender: widget.message.isSentByMe,
        textStyle: TextStyle(
          color: widget.message.isSentByMe ? Colors.white : Colors.black,
          fontSize: 15.sp,
        ),
      ),
    );
  }
}
