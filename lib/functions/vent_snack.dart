import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> vSnackBar({
  required BuildContext context, //必要的上下文
  //以下是可选参数
  Widget? textWidget, //设置默认content里的Text组件,如果是自定义content可以忽略这个选项
  Widget? content, //设置自定义content
  Color? bgcolor = Colors.blue, //设置背景颜色
  EdgeInsetsGeometry? padding = const EdgeInsets.all(16), //外边距
  EdgeInsetsGeometry? margin, //内边距(如果需要设置外边距，必须得位置方式设置为floating)
  SnackBarBehavior? behavior = SnackBarBehavior.fixed, //设置位置方式(并非设置位置)
  VoidCallback? onVisible, //在SnackBar显示之后的回调函数
  Duration? showTime, //持续时长
}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      onVisible: onVisible,
      elevation: 3, //景深
      duration: showTime ?? const Duration(seconds: 5),
      shape: const RoundedRectangleBorder(
        //形状
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      margin: margin,
      padding: padding,
      behavior: behavior,
      content: content ??
          VSnackContent(
            textWidget: textWidget,
          ),
      backgroundColor: bgcolor,
    ),
  );
}

//默认的content组件
class VSnackContent extends StatefulWidget {
  final Widget? textWidget;
  const VSnackContent({
    Key? key,
    this.textWidget = const Text(""),
  }) : super(key: key);

  @override
  State<VSnackContent> createState() => _VSnackContentState();
}

class _VSnackContentState extends State<VSnackContent> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        children: [
          const Icon(FontAwesomeIcons.solidThumbsUp),
          const SizedBox(width: 20),
          Expanded(
            child: widget.textWidget ?? const Text("你没有设置TextWidget这个参数值!!!"),
          ),
          const SizedBox(width: 5),
          IconButton(
            onPressed: () {
              //隐藏上下文内的SnackBar
              ScaffoldMessenger.of(context)
                  .hideCurrentSnackBar(reason: SnackBarClosedReason.action);
            },
            icon: const Icon(FontAwesomeIcons.check),
          ),
        ],
      ),
    );
  }
}
