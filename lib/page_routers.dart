import 'app.dart';
import 'pages/login_page.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> pageRouter() {
  return {
    "./": (context) => const AppPage(),
    "./login": (context) => const LoginPage(),
  };
}
