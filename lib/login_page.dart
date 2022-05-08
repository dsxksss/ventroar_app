import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import './home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool changeAnimated = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          OpenContainer(
            //过度时长
            transitionDuration: const Duration(seconds: 3),
            //打开时的过度颜色
            openColor: Colors.grey,
            //动画类型
            transitionType: ContainerTransitionType.fadeThrough,

            closedBuilder: (context, action) {
              return const Text(
                "Open new HomePage",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              );
            },
            openBuilder: (context, action) {
              //Scaffold顶部会自带一个返回按钮
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shadowColor: Colors.white,
                  centerTitle: true,
                  title: const Text("New HOME Page"),
                ),
                body: const HomePage(),
              );
            },
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 800),
            color: changeAnimated ? Colors.blue : Colors.greenAccent,
            width: changeAnimated ? 100 : 200,
            height: changeAnimated ? 100 : 250,
            curve: Curves.easeInOutQuint,
          ),
          FloatingActionButton(
            child: const Text("改变"),
            onPressed: () {
              setState(() {
                changeAnimated = !changeAnimated;
              });
            },
          )
        ],
      ),
    );
  }
}
