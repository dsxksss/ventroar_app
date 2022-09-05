import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../functions/vent_snack.dart';
import '../global/widgets/roar_widget.dart';
import '../services/network_lib.dart';
import 'pages_appbar/home_appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final ScrollController _scrollController;
  late Box<List<dynamic>> box;
  late List<dynamic> _roars;

  void getLocalData() {
    _roars = box.get("homePageRoars") ?? [];
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    box = Hive.box("roarsbox");
  }

  Future getAllRoar() async {
    try {
      var response = await RoarHttpLib().getAllRoarText(box: box);
      if (response["statusCode"] == 200) {
        setState(() {
          _roars = response["data"];
        });
      }
    } on DioError catch (e) {
      vSnackBar(
        showTime: const Duration(seconds: 60),
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
    getAllRoar();
    getLocalData();
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
              curve: Curves.easeInOutBack,
            ); //匀速;
          },
        ),
      ],
      body: RefreshIndicator(
        onRefresh: getAllRoar,
        child: ListView.builder(
          //确定每一个item的高度 会让item加载更加高效
          //  itemExtent: 83,
          //  primary: false,
          itemCount: _roars.isEmpty ? 1 : _roars.length,
          itemBuilder: (BuildContext context, int index) => _roars.isEmpty
              ? SizedBox(
                  width: 1.sw,
                  height: 0.7.sh,
                  child: const Center(
                    child: Text("尝试下拉屏幕获取内容"),
                  ),
                )
              : RoarWidget(roar: _roars[index]),
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0.2.sh),
          physics: const AlwaysScrollableScrollPhysics(
            //当内容不足时也可以启动反弹刷新
            parent: BouncingScrollPhysics(),
          ),
        ),
      ),
    );
  }
}
