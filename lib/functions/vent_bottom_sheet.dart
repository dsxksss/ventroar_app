import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

vBottomSheet({required BuildContext context}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Theme.of(context).backgroundColor,
    isScrollControlled: false,
    shape: const RoundedRectangleBorder(
      //顶部圆角
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      ),
    ),
    builder: (context) {
      return Container(
        decoration: BoxDecoration(
          //顶部圆角
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20),
          ),
          color: Theme.of(context).backgroundColor,
        ),
        height: 0.5.sh,
        child: const Text(""),
      );
    },
  );
}
