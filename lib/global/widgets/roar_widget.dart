import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ventroar_app/global/widgets/avatar_widget.dart';
import '../../functions/timestamp_conversion.dart';
import '../../schemas/roar.dart';

class RoarHeightSize {
  static double minHeight = 0.25.sh;
  static double maxHeight = 0.4.sh;
}

class RoarWidget extends StatefulWidget {
  const RoarWidget({Key? key, required this.roar, this.onPressed})
      : super(key: key);
  final Roar roar;
  final VoidCallback? onPressed;
  @override
  State<RoarWidget> createState() => _RoarWidgetState();
}

class _RoarWidgetState extends State<RoarWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        constraints: BoxConstraints(
          minHeight: RoarHeightSize.minHeight,
          maxHeight: RoarHeightSize.maxHeight,
          minWidth: 1.sw,
          maxWidth: 1.sw,
        ),
        decoration: const BoxDecoration(
          // color: Colors.red,
          border: Border(
            top: BorderSide(
              //分割线
              style: BorderStyle.solid,
              width: 0.2,
              color: Colors.grey,
            ),
          ),
        ),
        child: Flex(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          direction: Axis.horizontal,
          children: [
            RoarAvatar(
              userAvatarUrl: widget.roar.userAvatarUrl,
              userName: widget.roar.userName,
            ),
            RoarTitle(
              userName: widget.roar.userName,
              createDate: widget.roar.createDate,
            ),
          ],
        ),
      ),
    );
  }
}

class RoarAvatar extends StatelessWidget {
  const RoarAvatar({
    Key? key,
    required this.userAvatarUrl,
    required this.userName,
  }) : super(key: key);

  final String userAvatarUrl;
  final String userName;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.blue,
      constraints: BoxConstraints(
        minHeight: RoarHeightSize.minHeight,
        maxHeight: RoarHeightSize.maxHeight,
        minWidth: 0.2.sw,
        maxWidth: 0.2.sw,
      ),
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0.02.sh, 0.sw, 0),
            child: SizedBox(
              height: 55,
              width: 55,
              child: AvatarWidget(
                avatarUrl: userAvatarUrl,
                userName: userName,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RoarTitle extends StatelessWidget {
  const RoarTitle({
    Key? key,
    required this.userName,
    required this.createDate,
  }) : super(key: key);

  final String userName;
  final int createDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.yellow,
      constraints: BoxConstraints(
        minHeight: RoarHeightSize.minHeight,
        maxHeight: RoarHeightSize.maxHeight,
        minWidth: 0.8.sw,
        maxWidth: 0.8.sw,
      ),
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
              minHeight: 0.05.sh,
              maxHeight: 0.05.sh,
              minWidth: 0.8.sw,
              maxWidth: 0.8.sw,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  userName,
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      timestampConversion(createDate),
                      style: TextStyle(fontSize: 15.sp, color: Colors.grey),
                    ),
                    IconButton(
                      padding: EdgeInsets.fromLTRB(0.03.sw, 0, 0.03.sw, 0),
                      //覆盖原本icon内边距
                      constraints: BoxConstraints(minHeight: 0.02.sh),
                      onPressed: () {},
                      icon: const FaIcon(
                        FontAwesomeIcons.ellipsisVertical,
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
