import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:ventroar_app/functions/vent_dialog.dart';
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
  bool isPublic = true;
  bool isCanComment = true;
  bool isShowUserName = true;

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
                  if (contentText.isNotEmpty) {
                    vDialog(
                      context: context,
                      title: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.warning_amber_rounded,
                            color: Colors.amber[800],
                            size: 32.sp,
                          ),
                          Text(
                            " 注 意",
                            style: Theme.of(context).textTheme.headline3,
                          ),
                        ],
                      ),
                      contene: Text(
                        "已编辑内容还未发布,退出会重新编辑,确定退出嘛?",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      bottom: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            },
                            child: const Text("确定"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("取消"),
                          ),
                        ],
                      ),
                    );
                  } else {
                    Navigator.of(context).pop();
                  }
                },
                //去除按钮水波纹效果
                splashColor: Colors.transparent,
                icon: Icon(
                  Icons.close_rounded,
                  size: 30.sp,
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 0.1.sw,
                    height: 0.045.sh,
                    child: AvatarWidget(
                      avatarUrl: userBox.get("my")?.avatarUrl ?? "null",
                      userName: userBox.get("my")?.name ?? "null",
                    ),
                  ),
                  SizedBox(
                    width: 0.02.sw,
                  ),
                  Text(
                    "发布帖子",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
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
                  backgroundColor: MaterialStateProperty.all(Colors.lightBlue),
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
              Row(
                children: [
                  SizedBox(
                    width: 0.035.sw,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 0.052.sw,
                        height: 0.024.sh,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          //计算填充度
                          value: 500 * contentText.length * 4 / 1000000,
                          backgroundColor:
                              const Color.fromARGB(255, 154, 169, 177),
                          color: contentText.length > 500
                              ? Colors.redAccent
                              : const Color.fromARGB(255, 79, 193, 245),
                        ),
                      ),
                      SizedBox(
                        width: 0.02.sw,
                      ),
                      Text(
                        "/ 500",
                        style: TextStyle(
                          fontSize: 17.sp,
                          color: contentText.length > 500
                              ? Colors.redAccent
                              : null,
                        ),
                      ),
                      SizedBox(
                        width: 0.03.sw,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                width: 0.67.sw,
                height: 0.05.sh,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(
                    //当内容不足时也可以启动反弹刷新
                    parent: BouncingScrollPhysics(),
                  ),
                  children: [
                    FilterChip(
                      selected: isPublic,
                      showCheckmark: true,
                      checkmarkColor: Colors.white,
                      selectedColor: Colors.lightBlue,
                      backgroundColor: Colors.grey,
                      label: Text(
                        isPublic ? "内容公开" : "内容私密",
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      elevation: 1,
                      pressElevation: 1,
                      onSelected: (value) {
                        setState(
                          () {
                            isPublic = value;
                          },
                        );
                      },
                    ),
                    SizedBox(
                      width: 0.02.sw,
                    ),
                    FilterChip(
                      selected: isCanComment,
                      showCheckmark: true,
                      checkmarkColor: Colors.white,
                      selectedColor: Colors.lightBlue,
                      backgroundColor: Colors.grey,
                      label: Text(
                        isCanComment ? "可被评论" : "不被评论",
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      elevation: 1,
                      pressElevation: 1,
                      onSelected: (value) {
                        setState(
                          () {
                            isCanComment = value;
                          },
                        );
                      },
                    ),
                    SizedBox(
                      width: 0.02.sw,
                    ),
                    FilterChip(
                      selected: isShowUserName,
                      showCheckmark: true,
                      checkmarkColor: Colors.white,
                      selectedColor: Colors.lightBlue,
                      backgroundColor: Colors.grey,
                      label: Text(
                        isShowUserName ? "显示昵称" : "显示匿名",
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      elevation: 1,
                      pressElevation: 1,
                      onSelected: (value) {
                        setState(
                          () {
                            isShowUserName = value;
                          },
                        );
                      },
                    ),
                  ],
                ),
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
                  onChanged: (text) => setState(() {
                    contentText = text;
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
              ],
            ),
          )
        ],
      ),
    );
  }
}
