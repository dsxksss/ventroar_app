import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

vBottomSheet({
  required Widget content,
  required BuildContext context,
  bool? isEnableDrag,
  bool? isDismissible,
  bool? isShowDragWidget,
  double? height,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    enableDrag: isEnableDrag ?? true,
    isDismissible: isDismissible ?? true,
    clipBehavior: Clip.none,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return isShowDragWidget ?? true
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 0.02.sh,
                ),
                Container(
                  alignment: AlignmentDirectional.center,
                  width: 1.sw,
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
                SizedBox(
                  height: 0.005.sh,
                ),
                Container(
                  clipBehavior: Clip.none,
                  height: height ?? 0.3.sh,
                  width: 1.sw,
                  constraints: BoxConstraints(
                    minHeight: 0.3.sh,
                    maxHeight: 0.8.sh,
                    minWidth: 1.sw,
                    maxWidth: 1.sw,
                  ),
                  decoration: BoxDecoration(
                    //顶部圆角
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    color: Theme.of(context).backgroundColor,
                  ),
                  child: content,
                ),
              ],
            )
          : Container(
              clipBehavior: Clip.none,
              height: height ?? 0.3.sh,
              width: 1.sw,
              constraints: BoxConstraints(
                minHeight: 0.3.sh,
                maxHeight: 0.8.sh,
                minWidth: 1.sw,
                maxWidth: 1.sw,
              ),
              decoration: BoxDecoration(
                //顶部圆角
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                color: Theme.of(context).backgroundColor,
              ),
              child: content,
            );
    },
  );
}
