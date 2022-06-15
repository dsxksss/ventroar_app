import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ventroar_app/input_message_widget.dart';
import 'package:ventroar_app/message_bubble.dart';
import 'package:ventroar_app/pages/user_detail_page.dart';
import 'package:ventroar_app/schemas/message.dart';

class ChatPage extends StatefulWidget {
  final BuildContext context;
  final String titleText;
  const ChatPage({Key? key, required this.titleText, required this.context})
      : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ScrollController _scrollController = ScrollController();
  List<Message> messages = [
    Message(
      text:
          "Please try and give some feedback on it!Please try and give some feedback on itPlease try and give some feedback on itPlease try and give some feedback on itPlease try and give some feedback on it",
      date: DateTime.now(),
      isSentByMe: false,
    ),
    Message(
      text: "Please try and give some feedon it",
      date: DateTime.now(),
      isSentByMe: true,
    ),
    Message(
      text:
          "Please try and give some feedback on it!Please try and give se try and give some feedback on it",
      date: DateTime.now(),
      isSentByMe: true,
    ),
    Message(
      text:
          "Please try and give some feedback on it!Please try and give se try and give some feedback on it",
      date: DateTime.now(),
      isSentByMe: false,
    ),
  ].toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.titleText),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              FontAwesomeIcons.phone,
              size: 18,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 3, 0),
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
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                itemCount: messages.length,
                itemBuilder: (context, index) => MessageBubble(
                  message: messages[index],
                ),
              ),
            ),
            InputMessage(
              onSubmitted: (text) {
                final message = Message(
                  text: text,
                  date: DateTime.now(),
                  isSentByMe: true,
                );

                final robot = Message(
                  text:
                      "Hi👋! \t我叫 Robot\n我是一个机器人🤖\n检测到你输入了这些内容:\n$text\n酸 Q 👻 👻 👻",
                  date: DateTime.now(),
                  isSentByMe: false,
                );

                setState(
                  () {
                    messages.add(message);
                    Future.delayed(const Duration(milliseconds: 300), () {
                      _scrollController.animateTo(
                        _scrollController.position.maxScrollExtent,
                        duration: const Duration(milliseconds: 800),
                        curve: Curves.easeInOutBack,
                      ); //匀速;
                    });
                    Future.delayed(
                      const Duration(seconds: 3),
                      () {
                        setState(
                          () {
                            messages.add(robot);
                            Future.delayed(const Duration(milliseconds: 300),
                                () {
                              _scrollController.animateTo(
                                _scrollController.position.maxScrollExtent,
                                duration: const Duration(milliseconds: 800),
                                curve: Curves.easeInOutBack,
                              ); //匀速;
                            });
                          },
                        );
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
