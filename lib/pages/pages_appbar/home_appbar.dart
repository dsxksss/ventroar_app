import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ventroar_app/widgets/search_animation.dart';
import '../../contexts/global_provider.dart';
import '../../global/widgets/avatar_widget.dart';
import '../../schemas/user.dart';

class HomeAppBar extends StatefulWidget {
  const HomeAppBar({
    Key? key,
    this.onPressed,
  }) : super(key: key);
  final VoidCallback? onPressed;
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
      snap: true,
      pinned: false, //不固定在顶部
      primary: true,
      floating: true, //不随着滑动隐藏标题
      centerTitle: true,
      leading: AvatarWidget(
        size: 12,
        avatarUrl: box.get("my")?.avatarUrl ?? "null",
        userName: box.get("my")?.name ?? "null",
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),

      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).appBarTheme.backgroundColor,
        statusBarIconBrightness: context.watch<ThemeProvider>().isDark
            ? Brightness.light
            : Brightness.dark,
        statusBarBrightness: context.watch<ThemeProvider>().isDark
            ? Brightness.dark
            : Brightness.light,
      ),
      title: GestureDetector(
        child: Text(
          "${pageDatas[selectedIndex]}",
          style: GoogleFonts.ubuntu(fontSize: 25, fontWeight: FontWeight.w500),
        ),
        onTap: widget.onPressed,
      ),

      flexibleSpace: const FlexibleSpaceBar(
        centerTitle: true,
      ),
      actions: [
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0.03.sw, 0),
          child: SearchAnimation(
            height: 35,
            width: 35,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Scaffold(
                  appBar: AppBar(
                    centerTitle: true,
                    title: const Text("搜索"),
                  ),
                  body: Container(
                    color: Theme.of(context).canvasColor,
                    child: const Center(
                      child: SearchAnimation(
                        height: 300,
                        width: 300,
                      ),
                    ),
                  ),
                ),
              ));
            },
          ),
        ),
      ],
    );
  }
}
