import 'package:flutter/material.dart';
import './widgets/vent_button.dart';
import './vcolors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int a = 18;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        VTextButton(
          fullButton: false,
          textColor: VColors.vPtext,
          buttonColor: VColors.vBg100,
          onPressed: () {},
        ),
      ],
    );
  }
}

// DefaultTextStyle(
//   style: const TextStyle(
//     fontSize: 20.0,
//     color: Colors.blue,
//   ),
//   child: AnimatedTextKit(
//     animatedTexts: [
//       WavyAnimatedText('Hello World'),
//       WavyAnimatedText('Look at the waves'),
//     ],
//     isRepeatingAnimation: true,
//     repeatForever: true,
//     onTap: () {},
//   ),
// ),
//   a > 0
//       ? Badge(
//           badgeContent: Text(
//             a.toString(),
//             style: const TextStyle(color: Colors.white),
//           ),
//           animationType: BadgeAnimationType.slide,
//           animationDuration: const Duration(milliseconds: 500),
//           child: VTextIconButton(
//             buttonText: "WeChat",
//             buttonColor: Colors.green.shade400,
//             onPressed: () {
//               /// 延迟函数  记得在函数前加上async
//               // await Future.delayed(
//               //   const Duration(seconds: 1),
//               // );
//               setState(() {
//                 a -= 1;
//               });
//             },
//             icon: const Icon(
//               Icons.wechat,
//               color: Colors.white,
//             ),
//           ),
//         )
//       : VTextIconButton(
//           buttonText: "WeChat",
//           buttonColor: Colors.green.shade400,
//           onPressed: () {
//             /// 延迟函数  记得在函数前加上async
//             // await Future.delayed(
//             //   const Duration(seconds: 1),
//             // );
//             setState(() {
//               a -= 1;
//             });
//           },
//           icon: const Icon(
//             Icons.wechat,
//             color: Colors.white,
//           ),
//         ),
//   VFTextIconButton(
//     buttonText: "FaceBook",
//     onPressed: () {
//       vAlert(context, const Text("你好哇，我是标题"),
//           const Text("你可以试着修改我的内容喔"));
//     },
//     buttonShape: GFButtonShape.pills,
//     faIcon: const FaIcon(FontAwesomeIcons.facebook),
//   ),
//   VIconButton(
//     onPressed: () {
//       Fluttertoast.showToast(
//         msg: "消息通知: xxxxx",
//         textColor: Colors.white,
//         backgroundColor: Colors.red.shade400,
//         gravity: ToastGravity.TOP,
//         fontSize: 20,
//       );
//     },
//     icon: const Icon(Icons.settings),
//     buttonShape: GFIconButtonShape.circle,
//   ),
//
