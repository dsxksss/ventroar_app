import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

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
          Positioned(
            top: 0.06.sh,
            child: Container(
              width: 1.sw,
              padding: EdgeInsets.fromLTRB(0.02.sw, 0, 0.02.sw, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      FontAwesomeIcons.arrowLeft,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "${selectIndex + 1} - ${widget.images.length}",
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      FontAwesomeIcons.ellipsisVertical,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
