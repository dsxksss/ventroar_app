import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'pages_appbar/home_appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
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
      body: ListView(
        physics: const AlwaysScrollableScrollPhysics(
          //当内容不足时也可以启动反弹刷新
          parent: BouncingScrollPhysics(),
        ),
        children: [
          SizedBox(
            height: 1.sh,
            child: Column(
              children: [
                Text(
                  "星墙页面",
                  style: TextStyle(
                      fontSize: 30,
                      color: Theme.of(context).textTheme.bodyText1!.color),
                ),
                Text(
                  "(制作中)...",
                  style: TextStyle(
                      fontSize: 26,
                      color: Theme.of(context).textTheme.bodyText1!.color),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 1.sh,
            child: Column(
              children: [
                Text(
                  "星墙页面",
                  style: TextStyle(
                      fontSize: 30,
                      color: Theme.of(context).textTheme.bodyText1!.color),
                ),
                Text(
                  "(制作中)...",
                  style: TextStyle(
                      fontSize: 26,
                      color: Theme.of(context).textTheme.bodyText1!.color),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 1.sh,
            child: Column(
              children: [
                Text(
                  "星墙页面",
                  style: TextStyle(
                      fontSize: 30,
                      color: Theme.of(context).textTheme.bodyText1!.color),
                ),
                Text(
                  "(制作中)...",
                  style: TextStyle(
                      fontSize: 26,
                      color: Theme.of(context).textTheme.bodyText1!.color),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
