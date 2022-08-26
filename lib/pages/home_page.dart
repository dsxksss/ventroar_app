import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../global/widgets/roar.dart';
import '../schemas/user.dart';
import 'pages_appbar/home_appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final ScrollController _scrollController;
  late Box<User> box;
  late User _user;

  void getUserData() {
    _user = box.get("my")!;
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    box = Hive.box("userbox");
  }

  @override
  Widget build(BuildContext context) {
    getUserData();
    return NestedScrollView(
      controller: _scrollController,
      floatHeaderSlivers: true, //只要有下滑手势就显示appbar
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) =>
          <Widget>[
        HomeAppBar(
          onPressed: () {
            _scrollController.animateTo(
              _scrollController.position.minScrollExtent,
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeInOut,
            ); //匀速;
          },
        ),
      ],
      body: ListView(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0.2.sh),
        physics: const AlwaysScrollableScrollPhysics(
          //当内容不足时也可以启动反弹刷新
          parent: BouncingScrollPhysics(),
        ),
        children: [
          Roar(
            user: _user,
          ),
          const Divider(
            height: 30,
            thickness: 1.5,
          ),
          Roar(
            user: _user,
          ),
          const Divider(
            height: 30,
            thickness: 1.5,
          ),
          Roar(
            user: _user,
          ),
        ],
      ),
    );
  }
}
