import 'package:flutter/material.dart';

class UserFloatButton extends StatelessWidget {
  const UserFloatButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {},
      child: const Icon(Icons.person),
    );
  }
}
