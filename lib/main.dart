import './app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'contexts/global_provider.dart';
import 'databases/userdb/user_db.dart';
import 'package:ventroar_app/services/http_lib.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MaterialApp extends StatefulWidget {
  const MaterialApp({Key? key}) : super(key: key);

  @override
  State<MaterialApp> createState() => _MaterialAppState();
}

class _MaterialAppState extends State<MaterialApp> {
  @override
  void dispose() {
    UserDB.instance.close();
    Services.instance.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return ScreenUtilInit(
        //默认designSize:w360,h690
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (BuildContext context, Widget? child) =>
            MultiProvider(providers: [
          ChangeNotifierProvider(
            create: (context) => ThemeProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => PageDataProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => UserVerificationProvider(),
          ),
        ], child: const App()),
      );
    });
  }
}

void main() {
  //顶部状态栏透明
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  runApp(const MaterialApp());
}
