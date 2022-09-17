import 'package:flutter/material.dart';

class PostRoarWidget extends StatelessWidget {
  const PostRoarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: const Text("你好👋"),
    );
  }
}
