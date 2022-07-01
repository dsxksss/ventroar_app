import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InputMessage extends StatefulWidget {
  final Function(String) onSubmitted;
  const InputMessage({Key? key, required this.onSubmitted}) : super(key: key);

  @override
  State<InputMessage> createState() => _InputMessageState();
}

class _InputMessageState extends State<InputMessage> {
  final FocusNode _focusNode = FocusNode();
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 75.0,
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 00),
      color: Theme.of(context).appBarTheme.backgroundColor,
      child: Center(
        child: TextField(
          style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color),
          controller: _controller,
          cursorHeight: 25,
          decoration: const InputDecoration(
            prefixIcon: Icon(
              FontAwesomeIcons.solidPaperPlane,
              size: 20,
            ),
            border: InputBorder.none,
          ),
          onSubmitted: (text) {
            setState(() {
              widget.onSubmitted(text);
              FocusScope.of(context).requestFocus(_focusNode);
              _controller.clear();
            });
          },
        ),
      ),
    );
  }
}
