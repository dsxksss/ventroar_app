import 'package:flutter/material.dart';
import './ventroar_button_bar.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          shadowColor: Colors.white,
          centerTitle: true,
          title: const Text(
            "Vent Roar",
          ),
        ),
        bottomNavigationBar: const VentRoarButtonBar(),
      ),
    );
  }
}
