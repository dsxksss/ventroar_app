import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VBadge extends StatelessWidget {
  const VBadge({
    Key? key,
    required this.count,
  }) : super(key: key);
  final int count;
  @override
  Widget build(BuildContext context) {
    return count >= 99
        ? Badge(
            toAnimate: false,
            shape: BadgeShape.square,
            badgeColor: Colors.grey,
            borderRadius: BorderRadius.circular(20),
            padding: const EdgeInsets.all(2),
            badgeContent: Text('99+',
                style: TextStyle(color: Colors.white, fontSize: 11.sp)),
          )
        : Badge(
            toAnimate: false,
            borderRadius: BorderRadius.circular(20),
            badgeColor: Colors.grey,
            padding:
                count >= 10 ? const EdgeInsets.all(3) : const EdgeInsets.all(6),
            badgeContent: Text(
              count.toString(),
              style: TextStyle(
                  color: Colors.white, fontSize: count >= 10 ? 12.sp : 13.sp),
            ),
          );
  }
}
