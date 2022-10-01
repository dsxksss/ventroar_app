import 'package:flutter/material.dart';

class UserFloatButton extends StatelessWidget {
  const UserFloatButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      splashColor: Colors.transparent,
      onPressed: () {},
      child: const Icon(Icons.person),
    );
  }
}
