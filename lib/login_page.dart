import 'package:flutter/material.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import './widgets/vent_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          VTextIconButton(
            onPressed: () {},
            buttonText: "Login",
            buttonShape: GFButtonShape.pills,
            icon: const Icon(
              Icons.login,
            ),
          ),
        ],
      ),
    );
  }
}
