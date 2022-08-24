import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'pages_appbar/star_appbar.dart';

class StarPage extends StatefulWidget {
  const StarPage({Key? key}) : super(key: key);

  @override
  State<StarPage> createState() => _StarPageState();
}

class _StarPageState extends State<StarPage> {
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      floatHeaderSlivers: true, //只要有下滑手势就显示appbar
      headerSliverBuilder: starAppBar,
      body: ListView(
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
