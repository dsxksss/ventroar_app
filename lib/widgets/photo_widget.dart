import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ventroar_app/services/vent_apis.dart';

class PhotoWidget extends StatefulWidget {
  PhotoWidget({Key? key, required this.images, required this.selectIndex})
      : pageController = PageController(initialPage: selectIndex),
        super(key: key);
  final List images;
  final int selectIndex;
  final PageController pageController;
  @override
  State<PhotoWidget> createState() => _PhotoWidgetState();
}

class _PhotoWidgetState extends State<PhotoWidget> {
  late int selectIndex = widget.selectIndex;
  //这里能获取到padding
  final MediaQueryData data = MediaQueryData.fromWindow(window);
  @override
  void initState() {
    super.initState();
    //隐藏状态栏，保留底部按钮栏
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
  }

  @override
  void dispose() {
    //显示状态栏、底部按钮栏
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        size: data.size,
        //固定字号防止后续系统设置影响
        textScaleFactor: 1.0,
        //固定原屏幕的padding
        //防止后续关闭顶部导航了
        //或者底部导航栏导致的画面抖动
        padding: data.padding,
        viewPadding: data.viewPadding,
        viewInsets: data.viewInsets,
      ),
      child: Scaffold(
        primary: false,
        body: SizedBox(
          height: 1.sh,
          width: 1.sw,
          child: PhotoViewGallery.builder(
            pageController: widget.pageController,
            itemCount: widget.images.length,
            onPageChanged: (index) => setState(() {
              selectIndex = index;
            }),
            builder: (context, index) {
              return PhotoViewGalleryPageOptions(
                onTapUp: (context, details, controllerValue) {
                  Navigator.of(context).pop();
                },
                //捏合图片最小缩放和最大缩放
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.contained * 4,
                basePosition: Alignment.center,

                imageProvider: CachedNetworkImageProvider(
                  "${VentUrlsTest.imagesUrl}/${widget.images[index]}",
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
