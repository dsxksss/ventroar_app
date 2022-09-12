import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:ventroar_app/functions/date_conversion.dart';
import 'package:ventroar_app/global/widgets/avatar_widget.dart';

import '../../schemas/roar.dart';
import '../../functions/vent_snack.dart';
import '../../services/roar_http_lib.dart';

class RoarHeightSize {
  static double minHeight = 0.05.sh;
  static double maxHeight = 0.45.sh;
}

class RoarWidget extends StatefulWidget {
  const RoarWidget({
    Key? key,
    this.onPressed,
    required this.roar,
    required this.roarsBox,
  }) : super(key: key);
  final Roar roar;
  final Box<Roar> roarsBox;
  final VoidCallback? onPressed;
  @override
  State<RoarWidget> createState() => _RoarWidgetState();
}

class _RoarWidgetState extends State<RoarWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        constraints: BoxConstraints(
          minHeight: RoarHeightSize.minHeight,
          maxHeight: RoarHeightSize.maxHeight,
          minWidth: 1.sw,
          maxWidth: 1.sw,
        ),
        decoration: const BoxDecoration(
          // color: Colors.red,
          border: Border(
            top: BorderSide(
              //分割线
              style: BorderStyle.solid,
              width: 0.2,
              color: Colors.grey,
            ),
          ),
        ),
        // 结构框架:左侧头像内容、时间线样式
        child: Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 内容细节:左侧头像内容、时间线样式
            RoarAvatar(
              userAvatarUrl: widget.roar.userAvatarUrl,
              userName: widget.roar.userName,
            ),

            //结构框架:标题、内容、其他按钮
            Container(
              // color: Colors.yellow,
              constraints: BoxConstraints(
                minHeight: RoarHeightSize.minHeight,
                maxHeight: RoarHeightSize.maxHeight,
                minWidth: 0.8.sw,
                maxWidth: 0.8.sw,
              ),
              child: Flex(
                direction: Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                //最小占位
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 内容细节:其他按钮

                  //标题
                  RoarTitle(
                    id: widget.roar.id,
                    roarsBox: widget.roarsBox,
                    userName: widget.roar.userName,
                    createDate: widget.roar.createDate,
                  ),

                  //内容
                  RoarContent(
                    text: widget.roar.text,
                  ),

                  RoarLikes(
                    roar: widget.roar,
                    roarsBox: widget.roarsBox,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RoarAvatar extends StatelessWidget {
  const RoarAvatar({
    Key? key,
    required this.userAvatarUrl,
    required this.userName,
  }) : super(key: key);

  final String userAvatarUrl;
  final String userName;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.blue,
      constraints: BoxConstraints(
        minHeight: RoarHeightSize.minHeight,
        maxHeight: RoarHeightSize.maxHeight,
        minWidth: 0.2.sw,
        maxWidth: 0.2.sw,
      ),
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0.02.sh, 0.sw, 0),
            child: SizedBox(
              height: 55,
              width: 55,
              child: AvatarWidget(
                avatarUrl: userAvatarUrl,
                userName: userName,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RoarTitle extends StatefulWidget {
  const RoarTitle({
    Key? key,
    required this.id,
    required this.userName,
    required this.createDate,
    required this.roarsBox,
  }) : super(key: key);

  final String id;
  final Box<Roar> roarsBox;
  final String userName;
  final int createDate;

  @override
  State<RoarTitle> createState() => _RoarTitleState();
}

class _RoarTitleState extends State<RoarTitle> {
  @override
  Widget build(BuildContext context) {
    Future deleteRoarText() async {
      try {
        var response = await RoarHttpLib().deleteRoarText(deleteId: widget.id);
        if (response["statusCode"] == 200) {
          setState(() {
            widget.roarsBox.delete(widget.id);
          });
          vSnackBar(
            showTime: const Duration(seconds: 1),
            dismissDirection: DismissDirection.startToEnd,
            model: VSnackModel.success,
            isScroll: false,
            textWidget: Text(
              "删除成功",
              style: TextStyle(
                  fontSize: 17.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          );
        }
      } on DioError catch (e) {
        if (e.response!.statusCode == 404) {
          vSnackBar(
            showTime: const Duration(seconds: 1),
            dismissDirection: DismissDirection.startToEnd,
            model: VSnackModel.error,
            isScroll: false,
            textWidget: Text(
              "没找到该帖子!",
              style: TextStyle(
                  fontSize: 17.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          );
        } else {
          vSnackBar(
            showTime: const Duration(seconds: 1),
            dismissDirection: DismissDirection.startToEnd,
            model: VSnackModel.error,
            isScroll:
                e.type != DioErrorType.connectTimeout && e.response != null
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
    }

    return Container(
      constraints: BoxConstraints(
        minHeight: 0.05.sh,
        maxHeight: 0.05.sh,
        minWidth: 0.8.sw,
        maxWidth: 0.8.sw,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            widget.userName,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                dateConversion(widget.createDate),
                style: TextStyle(fontSize: 15.sp, color: Colors.grey),
              ),
              IconButton(
                padding: EdgeInsets.fromLTRB(0.03.sw, 0, 0.03.sw, 0),
                //覆盖原本icon内边距
                constraints: BoxConstraints(minHeight: 0.02.sh),
                onPressed: () {
                  vSnackBar(
                    model: VSnackModel.error,
                    textWidget: Text(
                      "确定要删除此条宣泄吗?",
                      style: TextStyle(
                          fontSize: 17.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    button: IconButton(
                      onPressed: () {
                        deleteRoarText();
                      },
                      icon: const Icon(FontAwesomeIcons.trash),
                    ),
                  );
                },
                icon: const FaIcon(
                  FontAwesomeIcons.ellipsisVertical,
                  size: 18,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class RoarContent extends StatelessWidget {
  const RoarContent({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.green,
      constraints: BoxConstraints(
        minWidth: 0.7.sw,
        maxWidth: 0.7.sw,
      ),
      child: Text(
        text,
        maxLines: 12,
        textAlign: TextAlign.start,
        style: TextStyle(
          fontSize: 13.sp,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

class RoarLikes extends StatefulWidget {
  const RoarLikes({
    Key? key,
    required this.roar,
    required this.roarsBox,
  }) : super(key: key);

  final Roar roar;
  final Box<Roar> roarsBox;

  @override
  State<RoarLikes> createState() => _RoarLikesState();
}

class _RoarLikesState extends State<RoarLikes> {
  @override
  Widget build(BuildContext context) {
    Future clickLike(String clickWho) async {
      try {
        var response = await RoarHttpLib().clickTextLikes(
          likeId: widget.roar.id,
          likeWho: clickWho,
        );
        if (response["statusCode"] == 200) {
          Roar newRoar = widget.roar;
          newRoar.smil = response["data"]["result"]["smil"];
          newRoar.heart = response["data"]["result"]["heart"];
          setState(() {
            widget.roarsBox.put(widget.roar.id, newRoar);
          });
        }
      } on DioError catch (e) {
        if (e.response!.statusCode == 404) {
          vSnackBar(
            showTime: const Duration(seconds: 1),
            dismissDirection: DismissDirection.startToEnd,
            model: VSnackModel.error,
            isScroll: false,
            textWidget: Text(
              "没找到该帖子!",
              style: TextStyle(
                  fontSize: 17.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          );
        } else {
          vSnackBar(
            showTime: const Duration(seconds: 1),
            dismissDirection: DismissDirection.startToEnd,
            model: VSnackModel.error,
            isScroll:
                e.type != DioErrorType.connectTimeout && e.response != null
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
    }

    return Container(
      constraints: BoxConstraints(
        minWidth: 0.7.sw,
        maxWidth: 0.7.sw,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextButton.icon(
            onPressed: () {
              clickLike("heart");
            },
            icon: Icon(
              widget.roar.heart <= 0
                  ? Icons.heart_broken_outlined
                  : FontAwesomeIcons.heart,
              size: widget.roar.heart <= 0 ? 26 : 21,
              color: widget.roar.heart <= 0 ? Colors.grey : Colors.redAccent,
            ),
            label: Text(
              widget.roar.heart <= 99 ? widget.roar.heart.toString() : "99+",
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          TextButton.icon(
            onPressed: () {
              clickLike("smil");
            },
            icon: Icon(
              widget.roar.smil <= 0
                  ? FontAwesomeIcons.faceSadTear
                  : FontAwesomeIcons.faceSmileBeam,
              color: widget.roar.smil <= 0 ? Colors.grey : Colors.amberAccent,
              size: 20,
            ),
            label: Text(
              widget.roar.smil <= 99 ? widget.roar.smil.toString() : "99+",
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          TextButton.icon(
            onPressed: () {},
            icon: Icon(
              FontAwesomeIcons.comment,
              size: 20,
              color:
                  widget.roar.textCommentCount <= 0 ? Colors.grey : Colors.blue,
            ),
            label: Text(
              widget.roar.textCommentCount <= 99
                  ? widget.roar.textCommentCount.toString()
                  : "99+",
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
