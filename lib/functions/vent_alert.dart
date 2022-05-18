import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import '../widgets/vent_button.dart';

//Future类型是用来处理一些未来可能发生的触发函数
Future vAlert(BuildContext context, Widget title, Widget content) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      actions: [
        VTextIconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          buttonColor: Colors.white60,
          buttonType: GFButtonType.solid,
          buttonShape: GFButtonShape.pills,
          buttonText: "明白",
          icon: const Icon(Icons.done),
        ),
      ],
      title: title,
      content: content,
      contentPadding: const EdgeInsets.all(25.0),
    ),
  );
}