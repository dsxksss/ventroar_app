import 'package:flutter/material.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> vSnackBar({
  required BuildContext context, //必要的上下文
  //以下是可选参数
  Widget? textWidget, //设置默认content里的Text组件,如果是自定义content可以忽略这个选项
  Widget? content, //设置自定义content
  Color? bgcolor = Colors.blue, //设置背景颜色
  EdgeInsetsGeometry? padding = const EdgeInsets.all(16), //外边距
  EdgeInsetsGeometry? margin, //内边距(如果需要设置外边距，必须得位置方式设置为floating)
  SnackBarBehavior? behavior = SnackBarBehavior.fixed, //设置位置方式(并非设置位置)
}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      margin: margin,
      padding: padding,
      behavior: behavior,
      content: content ??
          SnackContent(
            textWidget: textWidget,
          ),
      backgroundColor: bgcolor,
    ),
  );
}

//默认的content组件
class SnackContent extends StatefulWidget {
  final Widget? textWidget;
  const SnackContent({
    Key? key,
    this.textWidget = const Text(""),
  }) : super(key: key);

  @override
  State<SnackContent> createState() => _SnackContentState();
}

class _SnackContentState extends State<SnackContent> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.thumb_up),
        const SizedBox(width: 20),
        Expanded(
          child: widget.textWidget ?? const Text("你没有设置TextWidget这个参数值!!!"),
        ),
      ],
    );
  }
}
