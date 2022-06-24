import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../contexts/global_provider.dart';

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
          ElevatedButton(
            onPressed: () {
              Provider.of<UserVerificationProvider>(context, listen: false)
                  .changeLoginState(true);
            },
            child: const Text("Login"),
          ),
        ],
      ),
    );
  }
}
