import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum VSnackModel {
  info,
  warning,
  error,
  success,
}

Color? getModelBg(VSnackModel vSnackBar) {
  switch (vSnackBar) {
    case VSnackModel.info:
      return const Color.fromARGB(255, 62, 194, 255);

    case VSnackModel.success:
      return const Color.fromARGB(255, 9, 214, 95);

    case VSnackModel.warning:
      return const Color.fromARGB(255, 253, 122, 22);

    case VSnackModel.error:
      return const Color.fromARGB(255, 252, 81, 81);

    default:
      return null;
  }
}

Widget? getModelIcon(VSnackModel vSnackBar) {
  switch (vSnackBar) {
    case VSnackModel.info:
      return const FaIcon(FontAwesomeIcons.bullhorn, color: Colors.white);

    case VSnackModel.success:
      return const Icon(Icons.done_all, color: Colors.white);

    case VSnackModel.warning:
      return const FaIcon(FontAwesomeIcons.personDigging, color: Colors.white);

    case VSnackModel.error:
      return const FaIcon(FontAwesomeIcons.triangleExclamation,
          color: Colors.white);

    default:
      return null;
  }
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason>? vSnackBar({
  required BuildContext context, //必要的上下文
  //以下是可选参数
  Widget? textWidget, //设置默认content里的Text组件,如果是自定义content可以忽略这个选项
  Widget? content, //设置自定义content
  Widget? button, //设置自定义button
  Widget? icon, //设置自定义icon
  Color? bgcolor = Colors.lightBlue, //设置背景颜色
  VSnackModel? model, //一些自定义的颜色模式/如果设置则会覆盖bgcolor
  EdgeInsetsGeometry? padding = const EdgeInsets.all(16), //外边距
  EdgeInsetsGeometry? margin, //内边距(如果需要设置外边距，必须得位置方式设置为floating)
  SnackBarBehavior? behavior, //设置位置方式(并非设置位置)
  VoidCallback? onVisible, //在SnackBar显示之后的回调函数
  Duration? showTime, //持续时长
}) {
  //在显示其他snackbar之前，先删除当前snackbar
  ScaffoldMessenger.of(context).removeCurrentSnackBar();

  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      onVisible: onVisible ?? () => {},
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
      behavior: margin == null || behavior == SnackBarBehavior.fixed
          ? SnackBarBehavior.fixed
          : SnackBarBehavior.floating,
      content: content ??
          VSnackContent(
            textWidget: textWidget,
            buttons: button,
            icon: model != null ? getModelIcon(model) : icon,
          ),
      backgroundColor: model != null ? getModelBg(model) : bgcolor,
    ),
  );
}

//默认的content组件
class VSnackContent extends StatefulWidget {
  final Widget? textWidget;
  final Widget? buttons;
  final Widget? icon;
  const VSnackContent({
    Key? key,
    this.textWidget = const Text(""),
    this.icon,
    required this.buttons,
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
          if (widget.icon != null) widget.icon!,
          if (widget.icon != null) const SizedBox(width: 10),
          Expanded(
            child: widget.textWidget ?? const Text("你没有设置TextWidget这个参数值!!!"),
          ),
          const SizedBox(width: 5),
          widget.buttons ??
              IconButton(
                onPressed: () {
                  //隐藏上下文内的SnackBar
                  ScaffoldMessenger.of(context)
                      .hideCurrentSnackBar(reason: SnackBarClosedReason.action);
                },
                icon: const Icon(
                  FontAwesomeIcons.check,
                  color: Colors.white,
                ),
              ),
        ],
      ),
    );
  }
}
