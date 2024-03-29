import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:ventroar_app/functions/date_conversion.dart';
import 'package:ventroar_app/services/vent_apis.dart';

import '../schemas/user.dart';
import 'photo_widget.dart';
import 'avatar_widget.dart';
import '../../schemas/roar.dart';
import '../global/global_context.dart';
import '../../functions/vent_snack.dart';
import '../../services/roar_http_lib.dart';

class RoarHeightSize {
  static double minHeight = 0.05.sh;
  static double maxHeight = 0.7.sh;
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
  late Box<User> userBox;

  @override
  void initState() {
    super.initState();
    userBox = Hive.box("userbox");
  }

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

                  SizedBox(
                    height: 0.005.sh,
                  ),

                  //内容
                  RoarContent(
                    text: widget.roar.text,
                    //判断是否含有帖子图片
                    //并且判断是否超出了缩略图的最大显示
                    //如果超出了最大显示，则只显示前四张图片
                    images: widget.roar.textImages.isNotEmpty
                        ? widget.roar.textImages.length >= 4
                            ? [
                                widget.roar.textImages[0] as String,
                                widget.roar.textImages[1] as String,
                                widget.roar.textImages[2] as String,
                                widget.roar.textImages[3] as String
                              ]
                            : widget.roar.textImages
                        : [],
                  ),

                  RoarLikes(
                    roar: widget.roar,
                    userId: userBox.get("my")?.id ?? "null",
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "@",
                style: TextStyle(
                  fontSize: 19.sp,
                  color: const Color.fromARGB(255, 45, 137, 184),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 0.24.sw,
                child: Text(
                  widget.userName,
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                dateConversion(widget.createDate),
                style: TextStyle(
                    fontSize: 15.5.sp,
                    color: const Color.fromARGB(255, 114, 126, 132)),
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
                      icon: const Icon(
                        FontAwesomeIcons.trash,
                        color: Colors.white,
                      ),
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
    required this.images,
  }) : super(key: key);

  final String text;
  final List images;
  static final cacheManager = CacheManager(
    Config(
      "cacheManagerKey",
      //缓存图片数据超过五天自动删除
      stalePeriod: const Duration(days: 5),
      //缓存图片的最大限度
      //超过这个数值会删除老缓存数据
      //只缓存新的内容
      maxNrOfCacheObjects: 200,
    ),
  );
  @override
  Widget build(BuildContext context) {
    void openPhoto(int selectIndex) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PhotoWidget(
            images: images,
            selectIndex: selectIndex,
          ),
        ),
      );
    }

    return Container(
      // color: Colors.green,
      constraints: BoxConstraints(
        minWidth: 0.7.sw,
        maxWidth: 0.7.sw,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            //文字最大显示行数
            maxLines: images.length <= 2 ? 5 : 8,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 13.5.sp,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          images.isNotEmpty
              ? SizedBox(
                  height: 0.01.sh,
                )
              : SizedBox(
                  height: 0.sh,
                ),
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(images.length == 3 ? 3 : 10),
              ),
            ),
            child: Wrap(
              spacing: 2,
              runSpacing: 2,
              direction: images.length <= 2 ? Axis.vertical : Axis.horizontal,
              children: [
                ...images.asMap().entries.map(
                  (e) {
                    return GestureDetector(
                      child: CachedNetworkImage(
                        key: Key(e.value),
                        cacheKey: "${VentUrlsTest.imagesUrl}/${e.value}",
                        //数据控制器
                        cacheManager: cacheManager,
                        placeholderFadeInDuration:
                            const Duration(milliseconds: 100),
                        fadeInDuration: const Duration(milliseconds: 400),
                        fadeOutDuration: const Duration(milliseconds: 600),
                        // 载入widget
                        // placeholder: (context, url) => Container(
                        //   height: 60,
                        //   width: 60,
                        //   color: Colors.grey,
                        // ),
                        //出错widget
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error_outline_outlined),
                        fit: BoxFit.cover,
                        //只有两张图片显示宽度
                        width: images.length <= 2 ? 0.7.sw : 0.34.sw,
                        height: images.length <= 2
                            ? images.length == 1
                                ? 0.3.sh //只有一张图片显示高度
                                : 0.18.sh //只有两张图片显示高度
                            : 0.12.sh,
                        imageUrl: "${VentUrlsTest.imagesUrl}/${e.value}",
                      ),
                      onTap: () {
                        //关闭多余snackbar
                        ScaffoldMessenger.of(
                                NavigationService.navigatorKey.currentContext!)
                            .removeCurrentSnackBar();
                        openPhoto(e.key);
                      },
                    );
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class RoarLikes extends StatefulWidget {
  const RoarLikes({
    Key? key,
    required this.roar,
    required this.userId,
    required this.roarsBox,
  }) : super(key: key);

  final Roar roar;
  final String userId;
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
          newRoar.smilLikeUsers = response["data"]["result"]["smilLikeUsers"];
          newRoar.heart = response["data"]["result"]["heart"];
          newRoar.heartLikeUsers = response["data"]["result"]["heartLikeUsers"];
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
            //去除水波纹效果
            style: ButtonStyle(
                overlayColor: MaterialStateProperty.resolveWith((states) {
              return Colors.transparent;
            })),
            icon: Icon(
              widget.roar.heart <= 0
                  ? Icons.heart_broken_outlined
                  : FontAwesomeIcons.heart,
              size: widget.roar.heart <= 0 ? 26 : 21,
              color: widget.roar.heart > 0 &&
                      widget.roar.heartLikeUsers!.contains(widget.userId)
                  ? Colors.redAccent
                  : Colors.grey,
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
            //去除水波纹效果
            style: ButtonStyle(
                overlayColor: MaterialStateProperty.resolveWith((states) {
              return Colors.transparent;
            })),
            icon: Icon(
              widget.roar.smil <= 0
                  ? FontAwesomeIcons.faceSadTear
                  : FontAwesomeIcons.faceSmileBeam,
              color: widget.roar.smil > 0 &&
                      widget.roar.smilLikeUsers!.contains(widget.userId)
                  ? Colors.amberAccent
                  : Colors.grey,
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
            //去除水波纹效果
            style: ButtonStyle(
                overlayColor: MaterialStateProperty.resolveWith((states) {
              return Colors.transparent;
            })),
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
