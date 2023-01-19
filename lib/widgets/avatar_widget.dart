import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../services/vent_apis.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({
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
  final double? size;
  final double? fontSize;
  final VoidCallback? onPressed;
  final double? _borderRadius = 999;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: avatarUrl == "null"
          ? Container(
              decoration: BoxDecoration(
                color: Colors.blue[200],
                borderRadius: const BorderRadius.all(
                  Radius.circular(999),
                ),
              ),
              child: Center(
                child: Text(
                  userName[0],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: fontSize ?? 26.sp,
                  ),
                ),
              ))
          : CircleAvatar(
              radius: _borderRadius,
              backgroundImage: Image.network(
                "${VentUrlsTest.avatarsUrl}/$avatarUrl",
                fit: BoxFit.cover,
              ).image,
            ),
    );
  }
}
