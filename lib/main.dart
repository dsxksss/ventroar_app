import 'package:flutter/material.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:getwidget/shape/gf_icon_button_shape.dart';
import './ventroar_button_bar.dart';
import './widgets/vent_button.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              VTextButton(
                buttonText: "WeChat",
                buttonColor: Colors.green.shade400,
                onPressed: () {},
              ),
              VTextIconButton(
                onPressed: () {},
                buttonShape: GFButtonShape.pills,
                icon: const Icon(Icons.facebook),
              ),
              VIconButton(
                onPressed: () {},
                icon: const Icon(Icons.settings),
                buttonShape: GFIconButtonShape.circle,
              )
            ],
          ),
        ),
        bottomNavigationBar: const VentRoarButtonBar(),
      ),
    );
  }
}
