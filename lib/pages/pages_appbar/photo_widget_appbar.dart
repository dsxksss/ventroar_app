import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PhotoWidgetAppBar extends StatefulWidget {
  const PhotoWidgetAppBar({Key? key, required this.selectIndex, this.itemCount})
      : super(key: key);
  final int selectIndex;
  final int? itemCount;

  @override
  State<PhotoWidgetAppBar> createState() => _PhotoWidgetAppBarState();
}

class _PhotoWidgetAppBarState extends State<PhotoWidgetAppBar> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 10.h,
      child: Container(
        width: 1.sw,
        height: 0.1.sh,
        padding: EdgeInsets.fromLTRB(0.02.sw, 0, 0.02.sw, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
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
              "${widget.selectIndex + 1} - ${widget.itemCount}",
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
    );
  }
}
