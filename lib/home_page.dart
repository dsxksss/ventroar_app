import 'package:flutter/material.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:getwidget/shape/gf_icon_button_shape.dart';
import './functions/vent_alert.dart';
import './widgets/vent_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          VTextIconButton(
            buttonText: "WeChat",
            buttonColor: Colors.green.shade400,
            onPressed: () {},
            icon: const Icon(
              Icons.wechat,
              color: Colors.white,
            ),
          ),
          VTextIconButton(
            onPressed: () {
              vAlert(
                  context, const Text("你好哇，我是标题"), const Text("你可以试着修改我的内容喔"));
            },
            buttonShape: GFButtonShape.pills,
            icon: const Icon(Icons.facebook),
          ),
          VIconButton(
            onPressed: () {
              vAlert(context, const Text("你好哇，我是标题"),
                  const Text("我是这个提醒框里的内容，你可以试着修改我的内容喔"));
            },
            icon: const Icon(Icons.settings),
            buttonShape: GFIconButtonShape.circle,
          ),
        ],
      ),
    );
  }
}
