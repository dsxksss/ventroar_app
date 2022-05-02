import 'package:flutter/material.dart';
import 'package:getwidget/shape/gf_icon_button_shape.dart';
import './widgets/vent_button.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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
