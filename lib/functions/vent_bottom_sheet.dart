import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

vBottomSheet({required BuildContext context}) {
  showModalBottomSheet(
    context: context,
    elevation: 0.65.sh,
    anchorPoint: const Offset(100, 100),
    isScrollControlled: true,
    backgroundColor: Theme.of(context).backgroundColor,
    shape: const RoundedRectangleBorder(
      //顶部圆角
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      ),
    ),
    builder: (context) {
      return Container(
        clipBehavior: Clip.none,
        height: 0.65.sh,
        decoration: BoxDecoration(
          //顶部圆角
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20),
          ),
          color: Theme.of(context).backgroundColor,
        ),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: AlignmentDirectional.center,
          children: [
            Positioned(
              top: -0.013.sh,
              child: Container(
                decoration: BoxDecoration(
                  //顶部圆角
                  borderRadius: const BorderRadius.all(
                    Radius.circular(99),
                  ),
                  color: Colors.grey.shade300,
                ),
                height: 0.01.sh,
                width: 0.3.sw,
              ),
            ),
          ],
        ),
      );
    },
  );
}
