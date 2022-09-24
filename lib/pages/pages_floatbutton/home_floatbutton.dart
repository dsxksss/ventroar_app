import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ventroar_app/functions/vent_bottom_sheet.dart';

import '../../global/widgets/post_roar_widget.dart';

class HomeFloatButton extends StatelessWidget {
  const HomeFloatButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        vBottomSheet(
          height: 0.70.sh,
          isEnableDrag: false,
          isShowDragWidget: false,
          isDismissible: false,
          context: context,
          content: const PostRoarWidget(),
        );
      },
      child: const Icon(Icons.edit),
    );
  }
}
