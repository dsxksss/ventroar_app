import 'package:flutter/material.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:getwidget/shape/gf_icon_button_shape.dart';
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
          VTextButton(
            buttonText: "WeChat",
            buttonColor: Colors.green.shade400,
            onPressed: () {},
          ),
          VTextIconButton(
            onPressed: () {},
            buttonShape: GFButtonShape.pills,
            icon: const Icon(Icons.facebook),
          ),
          VIconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
            buttonShape: GFIconButtonShape.circle,
          )
        ],
      ),
    );
  }
}
