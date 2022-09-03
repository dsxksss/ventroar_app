import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ventroar_app/global/widgets/avatar_widget.dart';
import '../../schemas/roar.dart';

class RoarHeightSize {
  static double minHeight = 0.1.sh;
  static double maxHeight = 0.45.sh;
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
        // 结构框架:左侧头像内容、时间线样式
        child: Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 内容细节:左侧头像内容、时间线样式
            RoarAvatar(
              userAvatarUrl: widget.roar.userAvatarUrl,
              userName: widget.roar.userName,
            ),

            //结构框架:标题、内容、其他按钮
            Container(
              // color: Colors.yellow,
              constraints: BoxConstraints(
                minHeight: RoarHeightSize.minHeight,
                maxHeight: RoarHeightSize.maxHeight,
                minWidth: 0.8.sw,
                maxWidth: 0.8.sw,
              ),
              child: Flex(
                direction: Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                //最小占位
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 内容细节:其他按钮

                  //标题
                  RoarTitle(
                    userName: widget.roar.userName,
                    createDate: widget.roar.createDate,
                  ),

                  //内容
                  RoarContent(
                    text: widget.roar.text,
                  ),

                  RoarLikes(
                    heart: widget.roar.heart,
                    smil: widget.roar.smil,
                    commentCount: widget.roar.textCommentCount,
                  ),
                ],
              ),
            )
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
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                createDate.toString(),
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
    );
  }
}

class RoarContent extends StatelessWidget {
  const RoarContent({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.green,
      constraints: BoxConstraints(
        minWidth: 0.7.sw,
        maxWidth: 0.7.sw,
      ),
      child: Text(
        text,
        maxLines: 12,
        textAlign: TextAlign.start,
        style: TextStyle(
          fontSize: 13.sp,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

class RoarLikes extends StatelessWidget {
  const RoarLikes({
    Key? key,
    required this.heart,
    required this.smil,
    required this.commentCount,
  }) : super(key: key);

  final int heart;
  final int smil;
  final int commentCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minWidth: 0.7.sw,
        maxWidth: 0.7.sw,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextButton.icon(
            onPressed: () {},
            icon: Icon(
              heart <= 0 ? Icons.heart_broken_outlined : FontAwesomeIcons.heart,
              size: heart <= 0 ? 26 : 20,
              color: heart <= 0 ? Colors.grey : Colors.redAccent,
            ),
            label: Text(
              heart <= 99 ? heart.toString() : "99+",
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          TextButton.icon(
            onPressed: () {},
            icon: Icon(
              smil <= 0
                  ? FontAwesomeIcons.faceSadTear
                  : FontAwesomeIcons.faceSmileBeam,
              color: smil <= 0 ? Colors.grey : Colors.amberAccent,
              size: 20,
            ),
            label: Text(
              smil <= 99 ? smil.toString() : "99+",
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          TextButton.icon(
            onPressed: () {},
            icon: Icon(
              FontAwesomeIcons.comment,
              size: 20,
              color: commentCount <= 0 ? Colors.grey : Colors.blue,
            ),
            label: Text(
              commentCount <= 99 ? commentCount.toString() : "99+",
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
