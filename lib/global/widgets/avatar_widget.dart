import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AvatarWidget extends StatelessWidget {
  AvatarWidget({
    Key? key,
    borderRadius,
    this.size,
    this.fontSize,
    this.onPressed,
    required this.avatarUrl,
    required this.userName,
  }) : super(key: key);

  final String avatarUrl;
  final String userName;
  final double? fontSize;
  final VoidCallback? onPressed;
  final double? size;
  final BorderRadius? _borderRadius = BorderRadius.circular(999);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: EdgeInsets.all(size ?? 0),
        child: ClipRRect(
          borderRadius: _borderRadius,
          child: avatarUrl == "null"
              ? Container(
                  color: Colors.blue[200],
                  child: Center(
                    child: Text(
                      userName[0],
                      style: TextStyle(
                          color: Colors.white, fontSize: fontSize ?? 26.sp),
                    ),
                  ))
              : SizedBox(
                  child: Image.network(
                      "https://ventroar.xyz:2548/avatars/$avatarUrl"),
                ),
        ),
      ),
    );
  }
}
