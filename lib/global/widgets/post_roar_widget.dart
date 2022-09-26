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
  TextEditingController textEditingController = TextEditingController();
  String contentText = "";

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
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  elevation: MaterialStateProperty.all(0),
                ),
                child: const Text(
                  "发 帖",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
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
                  avatarUrl: userBox.get("my")?.avatarUrl ?? "null",
                  userName: userBox.get("my")?.name ?? "null",
                ),
              ),
              SizedBox(
                width: 0.03.sw,
              ),
            ],
          ),
          SizedBox(
            width: 0.9.sw,
            height: 0.53.sh,
            child: Column(
              children: [
                TextField(
                  controller: textEditingController,
                  onChanged: (string) => setState(() {
                    contentText = string;
                  }),
                  //自动补全
                  autocorrect: false,
                  //光标高度
                  cursorHeight: 20,
                  //最小字行
                  minLines: 1,
                  //最大字行
                  maxLines: 12,
                  scrollPadding: EdgeInsets.zero,
                  style: TextStyle(fontSize: 16.sp),
                  decoration: InputDecoration(
                    //提示文字样式
                    hintStyle: TextStyle(fontSize: 18.sp),
                    hintText: " 随便说些什么吧",
                    //取消下边框线
                    border: InputBorder.none,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "${contentText.length.toString()} / 500",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color:
                            contentText.length > 500 ? Colors.redAccent : null,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
