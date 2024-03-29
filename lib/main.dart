import './app.dart';
import './schemas/user.dart';
import './schemas/roar.dart';
import './schemas/roar_comment.dart';
import 'package:flutter/material.dart';
import 'contexts/global_provider.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ventroar_app/services/network_lib.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MaterialApp extends StatefulWidget {
  const MaterialApp({Key? key}) : super(key: key);

  @override
  State<MaterialApp> createState() => _MaterialAppState();
}

class _MaterialAppState extends State<MaterialApp> {
  @override
  void dispose() {
    Services.instance.close();
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return ScreenUtilInit(
          //默认designSize:w360,h690
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (BuildContext context, Widget? child) => MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => ThemeProvider()),
              ChangeNotifierProvider(create: (_) => PageDataProvider()),
            ],
            child: const App(),
          ),
        );
      },
    );
  }
}

Future<void> main() async {
  // init hive localDB
  await Hive.initFlutter();
  // Register Adapter
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(RoarAdapter());
  Hive.registerAdapter(RoarCommentAdapter());
  // open db box
  await Hive.openBox<User>('userbox');
  await Hive.openBox<Roar>('roarbox');
  await Hive.openBox<Roar>('roarsbox');
  // 如果是批量自定local类型的话,直接dynamic
  // await Hive.openBox<List<dynamic>>('roarsbox');

  runApp(const MaterialApp());
}
