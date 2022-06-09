import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  // bool _value1 = false;
  // bool _value2 = false;
  // bool _value3 = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [],
      ),
    );
  }
}

// //利用Padding组件来设置与其他组件之间的间距
// const Padding(
//   padding: EdgeInsets.fromLTRB(0, 80, 0, 80),
//   child: VSlidable(),
// ),
// const VSlidable(),
// VCheckBoxList(
//   isCheck: _value1,
//   onChanged: (value) {
//     setState(() {
//       _value1 = value!;
//     });
//   },
//   title: Text(
//     "我是一个选择框功能按钮",
//     style: TextStyle(color: VColors().vPtext),
//   ),
//   secondary: FaIcon(
//     FontAwesomeIcons.facebook,
//     color: VColors().vPtext,
//   ),
//   checkColor: VColors().vPtext,
//   activeColor: VColors().vPblue,
// ),
// VCheckBoxList(
//   isCheck: _value2,
//   onChanged: (value) {
//     setState(() {
//       _value2 = value!;
//     });
//   },
//   title: Text(
//     "我是一个选择框功能按钮",
//     style: TextStyle(color: VColors().vPtext),
//   ),
//   secondary: FaIcon(
//     FontAwesomeIcons.twitter,
//     color: VColors().vPtext,
//   ),
//   activeColor: VColors().vPblue,
//   checkColor: VColors().vPtext,
// ),
// VCheckBoxList(
//   isCheck: _value3,
//   onChanged: (value) {
//     setState(() {
//       _value3 = value!;
//     });
//   },
//   title: Text(
//     "我是一个选择框功能按钮",
//     style: TextStyle(color: VColors().vPtext),
//   ),
//   secondary: FaIcon(
//     FontAwesomeIcons.amazon,
//     color: VColors().vPtext,
//   ),
//   activeColor: VColors().vPblue,
//   checkColor: VColors().vPtext,
// ),
