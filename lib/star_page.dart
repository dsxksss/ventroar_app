import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class StarPage extends StatefulWidget {
  const StarPage({Key? key}) : super(key: key);

  @override
  State<StarPage> createState() => _StarPageState();
}

class _StarPageState extends State<StarPage> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return Fluttertoast.showToast(
          msg: "刷新屏幕",
          backgroundColor: Colors.blueAccent,
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_LONG,
          fontSize: 20,
        );
      },
      child: Center(
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: ListView(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AnimatedTextKit(
                      animatedTexts: [
                        WavyAnimatedText('试试往下滑动屏幕',
                            textStyle: const TextStyle(fontSize: 20)),
                      ],
                      isRepeatingAnimation: true,
                      repeatForever: true,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
