import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:ventroar_app/pages/pages_appbar/photo_widget_appbar.dart';

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
    return Scaffold(
      primary: false,
      body: Stack(
        children: [
          PhotoViewGallery.builder(
            pageController: widget.pageController,
            itemCount: widget.images.length,
            onPageChanged: (index) => setState(() {
              selectIndex = index;
            }),
            builder: (context, index) {
              return PhotoViewGalleryPageOptions(
                //捏合图片最小缩放和最大缩放
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.contained * 4,
                imageProvider: CachedNetworkImageProvider(
                    "https://ventroar.xyz:2548/images/${widget.images[index]}"),
              );
            },
          ),
          PhotoWidgetAppBar(
            selectIndex: selectIndex,
            itemCount: widget.images.length,
          ),
        ],
      ),
    );
  }
}
