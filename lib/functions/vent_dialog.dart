import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';

vDialog({
  required BuildContext context,
  Widget? title,
  Widget? contene,
  Widget? bottom,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        elevation: 2,
        //清除自带padding
        insetPadding: EdgeInsets.zero,
        backgroundColor: Theme.of(context).backgroundColor,
        shape: const RoundedRectangleBorder(
          //形状
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Container(
          constraints: BoxConstraints(
            minHeight: 0.2.sh,
            maxHeight: 0.3.sh,
            minWidth: 0.8.sw,
            maxWidth: 0.8.sw,
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              title ?? const Text(""),
              SizedBox(height: 0.02.sh),
              contene ?? const Text(""),
              SizedBox(height: 0.01.sh),
              bottom ?? const Text(""),
            ],
          ),
        ),
      );
    },
  );
}
