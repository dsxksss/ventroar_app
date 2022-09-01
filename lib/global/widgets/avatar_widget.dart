import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AvatarWidget extends StatelessWidget {
  AvatarWidget({
    Key? key,
    borderRadius,
    this.fontSize,
    this.onPressed,
    required this.avatarUrl,
    required this.userName,
  }) : super(key: key);

  final String avatarUrl;
  final String userName;
  final double? fontSize;
  final VoidCallback? onPressed;
  final BorderRadius? _borderRadius = BorderRadius.circular(999);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: ClipRRect(
        borderRadius: _borderRadius,
        child: avatarUrl == "null"
            ? Container(
                width: 50,
                height: 50,
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
    );
  }
}
