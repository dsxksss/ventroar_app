import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../schemas/user.dart';
import '../../widgets/avatar_widget.dart';
import '../../contexts/global_provider.dart';
import '../../widgets/search_animation.dart';

class HomeAppBar extends StatefulWidget {
  const HomeAppBar({
    Key? key,
    this.onPressed,
    this.onStretchTrigger,
  }) : super(key: key);
  final VoidCallback? onPressed;
  final Future<void> Function()? onStretchTrigger;
  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  late Box<User> box;
  @override
  void initState() {
    super.initState();
    box = Hive.box("userbox");
  }

  @override
  Widget build(BuildContext context) {
    final Map pageDatas = Provider.of<PageDataProvider>(context).pageDatas;
    final int selectedIndex =
        Provider.of<PageDataProvider>(context).selectedIndex;
    return SliverAppBar(
      pinned: false, //不固定在顶部
      primary: true, //是否跟随父组件布局适配
      floating: true, //不随着滑动隐藏标题
      centerTitle: false, //是否居中标题
      stretch: true, //是否启用拉伸效果
      stretchTriggerOffset: 150, //激活onStretchTrigger过渡的偏移量
      expandedHeight: 0.sh, //扩展高度

      titleSpacing: 0.0, //title widget两边不留间隙
      onStretchTrigger: widget.onStretchTrigger,
      automaticallyImplyLeading: false,

      //圆角appbar
      // shape: const RoundedRectangleBorder(
      //   borderRadius: BorderRadius.only(
      //     bottomLeft: Radius.circular(20.0),
      //     bottomRight: Radius.circular(20.0),
      //   ),
      // ),

      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).appBarTheme.backgroundColor,
        statusBarIconBrightness: context.watch<ThemeProvider>().isDark
            ? Brightness.light
            : Brightness.dark,
        statusBarBrightness: context.watch<ThemeProvider>().isDark
            ? Brightness.dark
            : Brightness.light,
      ),
      title: Container(
        width: 1.sw,
        height: 0.1.sh,
        padding: EdgeInsets.fromLTRB(15.w, 0, 15.w, 0),
        child: GestureDetector(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 30.w,
                height: 30.w,
                child: AvatarWidget(
                  avatarUrl: box.get("my")?.avatarUrl ?? "null",
                  userName: box.get("my")?.name ?? "null",
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              ),
              Text(
                "${pageDatas[selectedIndex]}",
                style: GoogleFonts.ubuntu(
                    fontSize: 25, fontWeight: FontWeight.w500),
              ),
              SearchAnimation(
                height: 35.w,
                width: 35.w,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Scaffold(
                      appBar: AppBar(
                        centerTitle: true,
                        title: const Text("搜索"),
                      ),
                      body: Container(
                        color: Theme.of(context).canvasColor,
                        child: Center(
                          child: SearchAnimation(
                            height: 300.w,
                            width: 300.w,
                          ),
                        ),
                      ),
                    ),
                  ));
                },
              )
            ],
          ),
          onTap: widget.onPressed,
        ),
      ),
    );
  }
}
