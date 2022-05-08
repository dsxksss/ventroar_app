import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ventroar_app/widgets/vent_checkboxlist.dart';
import './widgets/vent_slidable.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  bool _value1 = false;
  bool _value2 = false;
  bool _value3 = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //利用Padding组件来设置与其他组件之间的间距
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 80, 0, 80),
            child: VSlidable(),
          ),
          const VSlidable(),
          VCheckBoxList(
            isCheck: _value1,
            onChanged: (value) {
              setState(() {
                _value1 = value!;
              });
            },
            title: const Text("我是一个选择框功能按钮"),
            secondary: const FaIcon(FontAwesomeIcons.facebook),
          ),
          VCheckBoxList(
            isCheck: _value2,
            onChanged: (value) {
              setState(() {
                _value2 = value!;
              });
            },
            title: const Text("我是一个选择框功能按钮"),
            secondary: const FaIcon(FontAwesomeIcons.twitter),
          ),
          VCheckBoxList(
            isCheck: _value3,
            onChanged: (value) {
              setState(() {
                _value3 = value!;
              });
            },
            title: const Text("我是一个选择框功能按钮"),
            secondary: const FaIcon(FontAwesomeIcons.amazon),
          ),
        ],
      ),
    );
  }
}
