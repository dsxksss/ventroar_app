import 'package:dio/dio.dart';
import 'pages_appbar/home_appbar.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../schemas/roar.dart';
import '../functions/vent_snack.dart';
import '../services/roar_http_lib.dart';
import '../global/widgets/roar_widget.dart';

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
      body: RefreshIndicator(
        onRefresh: getAllRoar,
        child: ValueListenableBuilder(
          valueListenable: roarsBox.listenable(),
          builder: (context, Box<Roar> box, _) {
            List<Roar> roars = box.values.toList();
            //按发布时间排序
            roars.sort((a, b) => b.createDate.compareTo(a.createDate));
            return ListView.builder(
              itemCount: roars.isEmpty ? 1 : roars.length,
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0.2.sh),
              physics: const AlwaysScrollableScrollPhysics(
                //当内容不足时也可以启动反弹刷新
                parent: BouncingScrollPhysics(),
              ),
              itemBuilder: (context, index) => roars.isEmpty
                  ? SizedBox(
                      width: 1.sw,
                      height: 0.7.sh,
                      child: const Center(
                        child: Text("尝试下拉屏幕获取内容"),
                      ),
                    )
                  : RoarWidget(roar: roars[index], roarsBox: roarsBox),
            );
          },
        ),
      ),
    );
  }
}
