import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import '../contexts/global_provider.dart';
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
    return RawScrollbar(
      thumbColor: Colors.grey,
      //是否一直可见滚动条
      thumbVisibility: true,
      //滚动条圆角
      radius: const Radius.circular(999),
      //滚动条宽度
      thickness: 4,
      //滚动条显示位置(默认右边)
      scrollbarOrientation: ScrollbarOrientation.right,
      //滚动控制
      controller: _scrollController,
      child: CustomScrollView(
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

          // 检查上下文是否有加载事件
          SliverToBoxAdapter(
            child: Visibility(
              visible: context.watch<PageDataProvider>().haveLoading,
              child: LinearProgressIndicator(
                color: Colors.lightBlue,
                backgroundColor: Colors.transparent,
                value: context.watch<PageDataProvider>().loadingProgress,
              ),
            ),
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
      ),
    );
  }
}
