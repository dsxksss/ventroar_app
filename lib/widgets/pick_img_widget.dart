import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PickImgWidget extends StatefulWidget {
  const PickImgWidget(
      {Key? key, required this.imagePaths, required this.onPick})
      : super(key: key);

  final List<dynamic> imagePaths;
  final VoidCallback onPick;
  @override
  State<PickImgWidget> createState() => _PickImgWidgetState();
}

class _PickImgWidgetState extends State<PickImgWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0.1.sh,
      width: 1.sw,
      child: Stack(
        children: [
          Positioned(
              left: 0,
              bottom: 0,
              child: Row(
                children: [
                  if (widget.imagePaths.isNotEmpty)
                    SizedBox(
                      height: 0.1.sh,
                      width: widget.imagePaths.length == 4 ? 1.sw : 0.75.sw,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        physics: const AlwaysScrollableScrollPhysics(
                          //当内容不足时也可以启动反弹刷新
                          parent: BouncingScrollPhysics(),
                        ),
                        children: [
                          ...widget.imagePaths.map((e) => SizedBox(
                              height: 0.1.sh,
                              width: 0.2.sw,
                              child: Image.file(File(e)))),
                        ],
                      ),
                    ),
                  if (widget.imagePaths.length < 4)
                    Center(
                      child: IconButton(
                        onPressed: widget.onPick,
                        icon: Icon(
                          Icons.photo,
                          size: 50.sp,
                        ),
                      ),
                    ),
                ],
              ))
        ],
      ),
    );
  }
}
