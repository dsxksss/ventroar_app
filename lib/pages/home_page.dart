import 'package:dio/dio.dart';
import 'pages_appbar/home_appbar.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../schemas/roar.dart';
import '../widgets/roar_widget.dart';
import '../functions/vent_snack.dart';
import '../services/roar_http_lib.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final ScrollController _scrollController;
  late Box<Roar> roarsBox;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    roarsBox = Hive.box("roarsbox");
  }

  Future getAllRoar() async {
    try {
      var response = await RoarHttpLib().getAllRoarText(box: roarsBox);
      if (response["statusCode"] == 200) {}
    } on DioError catch (e) {
      vSnackBar(
        showTime: const Duration(seconds: 2),
        dismissDirection: DismissDirection.startToEnd,
        model: VSnackModel.error,
        isScroll: e.type != DioErrorType.connectTimeout && e.response != null
            ? true
            : false,
        textWidget: Text(
          e.type == DioErrorType.connectTimeout
              ? "网络超时,请检查网络重试!"
              : e.response?.data["msg"] ?? "未连接网络,请检查后重试!",
          style: TextStyle(
              fontSize: 17.sp,
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      physics: const AlwaysScrollableScrollPhysics(
        //当内容不足时也可以启动反弹刷新
        parent: BouncingScrollPhysics(),
      ),
      slivers: <Widget>[
        //头部appbar
        HomeAppBar(
          onPressed: () {
            _scrollController.animateTo(
              _scrollController.position.minScrollExtent,
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeInOut,
            ); //匀速;
          },
          onStretchTrigger: getAllRoar,
        ),

        //帖子
        ValueListenableBuilder(
          valueListenable: roarsBox.listenable(),
          builder: (BuildContext context, Box<Roar> box, Widget? child) {
            List<Roar> roars = roarsBox.values.toList();
            roars.sort((a, b) => b.createDate.compareTo(a.createDate));
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                ((context, index) => roars.isEmpty
                    ? SizedBox(
                        width: 1.sw,
                        height: 0.7.sh,
                        child: const Center(
                          child: Text("尝试下拉屏幕获取内容"),
                        ),
                      )
                    : RoarWidget(roar: roars[index], roarsBox: roarsBox)),
                childCount: roars.isEmpty ? 1 : roars.length,
              ),
            );
          },
        ),
      ],
    );
  }
}
