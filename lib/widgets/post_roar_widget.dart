import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:ventroar_app/functions/vent_dialog.dart';
import 'package:ventroar_app/widgets/pick_img_widget.dart';

import '../contexts/global_provider.dart';
import 'avatar_widget.dart';
import '../../schemas/roar.dart';
import '../../schemas/user.dart';
import '../../functions/vent_snack.dart';
import '../../services/roar_http_lib.dart';

class PostRoarWidget extends StatefulWidget {
  const PostRoarWidget({Key? key}) : super(key: key);

  @override
  State<PostRoarWidget> createState() => _PostRoarWidgetState();
}

class _PostRoarWidgetState extends State<PostRoarWidget> {
  late Box<User> userBox;
  late Box<Roar> roarsBox;
  String contentText = "";
  bool isPublic = true;
  bool isCanComment = true;
  bool isShowUserName = true;
  List imagePath = [];
  List<dynamic> images = [];
  final ImagePicker _picker = ImagePicker();
  late Function changeHaveLoading;
  late Function changeLoadingProgress;
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    changeHaveLoading =
        Provider.of<PageDataProvider>(context, listen: false).changeHaveLoading;
    userBox = Hive.box("userbox");
    changeLoadingProgress =
        Provider.of<PageDataProvider>(context, listen: false)
            .changeLoadingProgress;
    roarsBox = Hive.box("roarsbox");
  }

  @override
  void dispose() {
    if (mounted) super.dispose();
  }

  Future pickImg() async {
    //imageQuality 压缩率 0~100
    var result = await _picker.pickMultiImage(imageQuality: 80);

    if (result != null) {
      setState(() {
        for (var element in result) {
          if (imagePath.length < 4 && images.length < 4) {
            imagePath.add(element.path);
            images.add(MultipartFile.fromFileSync(element.path,
                filename: element.name));
          }
        }
      });
    }
  }

  Future postText() async {
    try {
      Navigator.of(context).pop();
      changeHaveLoading(true);
      var response = await RoarHttpLib().postRoarText(
        box: roarsBox,
        //清除帖子左右空格后再发送
        text: textEditingController.text.trim(),
        isPublic: isPublic,
        isCanComment: isCanComment,
        isShowUserName: isShowUserName,
      );
      if (response["statusCode"] == 200) {
        if (imagePath.isNotEmpty && images.isNotEmpty) {
          changeHaveLoading(true);
          await postTextImages(response["data"]["result"]["_id"]);
        } else {
          changeHaveLoading(false);
        }
      }
    } on DioError catch (e) {
      vSnackBar(
        showTime: const Duration(seconds: 1),
        dismissDirection: DismissDirection.startToEnd,
        model: VSnackModel.error,
        isScroll: e.type != DioErrorType.connectTimeout && e.response != null
            ? true
            : false,
        textWidget: Text(
          e.type == DioErrorType.connectTimeout
              ? "发帖失败网络超时,请检查网络重试!"
              : e.response?.data["msg"] ?? "未连接网络,请检查后重试!",
          style: TextStyle(
              fontSize: 17.sp,
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
      );
    }
  }

  Future postTextImages(String textId) async {
    try {
      var response = await RoarHttpLib().postTextImages(
        box: roarsBox,
        textId: textId,
        files: images,
        onSendProgress: (count, total) {
          changeLoadingProgress((count / total) + 0.0);
        },
      );
      if (response["statusCode"] == 200) {
        changeHaveLoading(false);
        changeLoadingProgress(0.0);
      }
    } on DioError catch (e) {
      vSnackBar(
        showTime: const Duration(seconds: 1),
        dismissDirection: DismissDirection.startToEnd,
        model: VSnackModel.error,
        isScroll: e.type != DioErrorType.connectTimeout && e.response != null
            ? true
            : false,
        textWidget: Text(
          e.type == DioErrorType.connectTimeout
              ? "发帖失败网络超时,请检查网络重试!"
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
    return AnimatedContainer(
      duration: const Duration(seconds: 2),
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AnimatedContainer(
            duration: const Duration(seconds: 2),
            child: Row(
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
                SizedBox(
                  height: 0.05.sh,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 28.w,
                        height: 28.w,
                        child: AvatarWidget(
                          avatarUrl: userBox.get("my")?.avatarUrl ?? "null",
                          userName: userBox.get("my")?.name ?? "null",
                        ),
                      ),
                      SizedBox(
                        width: 0.02.sw,
                      ),
                      Container(
                        constraints: BoxConstraints(
                          minWidth: 0.sw,
                          maxWidth: 0.35.sw,
                        ),
                        child: Text(
                          userBox.get("my")?.name ?? "null",
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 0.02.sw,
                      ),
                    ],
                  ),
                ),
                if (textEditingController.text.trim().length >= 3)
                  ElevatedButton(
                    onPressed: () {
                      postText();
                    },
                    //设置圆角按钮
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.lightBlue),
                      elevation: MaterialStateProperty.all(0),
                    ),
                    child: const Text(
                      "发 布",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
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
                width: 0.68.sw,
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
            height: 0.55.sh,
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
                  // minLines: 1,
                  //最大字行
                  maxLines: 15,
                  scrollPadding: EdgeInsets.zero,
                  style: TextStyle(fontSize: 16.sp),
                  decoration: InputDecoration(
                    //提示文字样式
                    hintStyle: TextStyle(fontSize: 18.sp),
                    hintText: " 随便说些什么吧 (发帖最少3个字)",
                    //取消下边框线
                    border: InputBorder.none,
                  ),
                ),
                PickImgWidget(
                  imagePaths: imagePath,
                  onPick: pickImg,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
