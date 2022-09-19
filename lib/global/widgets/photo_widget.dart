import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
  late int _index = widget.selectIndex;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 45,
        title: Text("${_index + 1} - ${widget.images.length}"),
      ),
      body: PhotoViewGallery.builder(
        pageController: widget.pageController,
        itemCount: widget.images.length,
        onPageChanged: (index) => setState(() {
          _index = index;
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
    );
  }
}
