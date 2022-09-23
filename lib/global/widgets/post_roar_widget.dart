import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:ventroar_app/global/widgets/avatar_widget.dart';

import '../../schemas/user.dart';

class PostRoarWidget extends StatefulWidget {
  const PostRoarWidget({Key? key}) : super(key: key);

  @override
  State<PostRoarWidget> createState() => _PostRoarWidgetState();
}

class _PostRoarWidgetState extends State<PostRoarWidget> {
  late Box<User> userBox;

  @override
  void initState() {
    super.initState();
    userBox = Hive.box("userbox");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                //去除按钮水波纹效果
                splashColor: Colors.transparent,
                icon: Icon(
                  Icons.close_rounded,
                  size: 30.sp,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                //设置圆角按钮
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.67),
                    ),
                  ),
                ),
                child: const Text(
                  "发 帖",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          SizedBox(
            height: 0.01.sh,
          ),
          Row(
            children: [
              SizedBox(
                width: 0.01.sw,
              ),
              SizedBox(
                width: 40,
                height: 40,
                child: AvatarWidget(
                  avatarUrl: userBox.get("my")!.avatarUrl,
                  userName: userBox.get("my")!.name,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
