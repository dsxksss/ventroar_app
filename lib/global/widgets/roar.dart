import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ventroar_app/global/widgets/avatars.dart';
import '../../functions/timestamp_conversion.dart';
import '../../schemas/user.dart';

class Roar extends StatefulWidget {
  const Roar({Key? key, required this.user, this.onPressed}) : super(key: key);
  final User user;
  final VoidCallback? onPressed;
  @override
  State<Roar> createState() => _RoarState();
}

class _RoarState extends State<Roar> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              //分割线
              style: BorderStyle.solid,
              width: 0.2,
              color: Colors.grey,
            ),
          ),
          // color: Colors.red,
        ),
        child: Flex(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          direction: Axis.horizontal,
          children: [
            Container(
              // color: Colors.blue,
              constraints: BoxConstraints(minHeight: 0.44.sh, maxWidth: 0.2.sw),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0.04.sw, 0.02.sh, 0.03.sw, 0),
                    child: Avatar(user: widget.user),
                  ),
                ],
              ),
            ),
            Container(
              // color: Colors.yellow,
              padding: EdgeInsets.fromLTRB(0, 0.02.sh, 0, 0),
              constraints:
                  BoxConstraints(minHeight: 0.01.sh, minWidth: 0.80.sw),
              child: Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.zero,
                    child: Row(
                      children: [
                        Text(
                          widget.user.name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.sp),
                        ),
                        Padding(
                          //日期显示边距
                          padding: EdgeInsets.fromLTRB(0.25.sw, 0, 0, 0),
                          child: Text(
                            timestampConversion(widget.user.createDate),
                            style: TextStyle(fontSize: 15.sp),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.fromLTRB(0, 0, 0.03.sw, 0),
                    //覆盖原本icon内边距
                    constraints: BoxConstraints(minHeight: 0.01.sh),
                    onPressed: () {},
                    icon: const FaIcon(
                      FontAwesomeIcons.ellipsisVertical,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
