import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './app.dart';

void main() {
  //顶部状态栏透明
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  runApp(const App());
}
