import 'package:flutter/material.dart';

class InputPage extends StatefulWidget {
  final BuildContext context;
  final String titleText;
  const InputPage({Key? key, required this.titleText, required this.context})
      : super(key: key);

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
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
