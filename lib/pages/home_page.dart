import 'package:flutter/material.dart';
import 'package:ventroar_app/widgets/wait_animation.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const WaitAnimation();
  }
}
