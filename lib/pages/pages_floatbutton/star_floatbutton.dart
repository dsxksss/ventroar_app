import 'package:flutter/material.dart';

class StarFloatButton extends StatelessWidget {
  const StarFloatButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {},
      child: const Icon(Icons.star_border_rounded),
    );
  }
}
