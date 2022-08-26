import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ventroar_app/global/widgets/avatars.dart';
import '../../schemas/user.dart';

class Roar extends StatefulWidget {
  const Roar({Key? key, required this.user}) : super(key: key);
  final User user;
  @override
  State<Roar> createState() => _RoarState();
}

class _RoarState extends State<Roar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 0.05.sw, left: 0.05.sw),
      child: Flex(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        direction: Axis.horizontal,
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: 0.13.sw),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0.sh),
                  child: Avatar(user: widget.user),
                ),
              ],
            ),
          ),
          Container(
            constraints: BoxConstraints(minHeight: 0.28.sh),
            width: 0.77.sw,
            color: Colors.yellow,
            child: const Text("content"),
          ),
        ],
      ),
    );
  }
}
