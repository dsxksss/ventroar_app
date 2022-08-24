import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../schemas/user.dart';

class Avatar extends StatelessWidget {
  Avatar({
    Key? key,
    borderRadius,
    this.fontSize,
    this.onPressed,
    required user,
  })  : _user = user,
        super(key: key);

  final User _user;
  final double? fontSize;
  final VoidCallback? onPressed;
  final BorderRadius? _borderRadius = BorderRadius.circular(999);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: ClipRRect(
        borderRadius: _borderRadius,
        child: _user.avatarUrl == "null"
            ? Container(
                color: Colors.blue[200],
                child: Center(
                  child: Text(
                    _user.name[0],
                    style: TextStyle(
                        color: Colors.white, fontSize: fontSize ?? 26.sp),
                  ),
                ))
            : SizedBox(
                child: Image.network(
                    "https://ventroar.xyz:2548/avatars/${_user.avatarUrl}"),
              ),
      ),
    );
  }
}
