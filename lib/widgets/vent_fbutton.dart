import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//导入第三方外部getwidget库
import 'package:getwidget/getwidget.dart';

class VFTextIconButton extends StatefulWidget {
  //按钮样式
  final String buttonText; //按钮文字
  final Color textColor; //按钮文字颜色
  final double buttonSize; //按钮尺寸
  final Color buttonColor; //按钮颜色
  final GFButtonType buttonType; //按钮样式
  final GFButtonShape buttonShape; //按钮边框圆角
  final FaIcon faIcon; //按钮图标设置

  //按钮布局
  //blockBtton/fullWidthButton只能二选一
  final bool blockBtton; //是否启用占满容器
  final bool fullButton; //是否启用整宽按钮

  //按钮交互
  final VoidCallback onPressed; //按下按钮调用的函数

  const VFTextIconButton({
    Key? key,
    this.buttonText = "BUTTON",
    this.textColor = Colors.black,
    this.buttonColor = Colors.blueAccent,
    this.buttonSize = GFSize.LARGE,
    this.buttonType = GFButtonType.solid,
    this.buttonShape = GFButtonShape.standard,
    this.blockBtton = false,
    this.fullButton = false,
    required this.onPressed,
    required this.faIcon,
  }) : super(key: key);
  @override
  State<VFTextIconButton> createState() => _VFTextIconButtonState();
}

class _VFTextIconButtonState extends State<VFTextIconButton> {
  @override
  Widget build(BuildContext context) {
    return GFButton(
      onPressed: widget.onPressed,
      text: widget.buttonText,
      type: widget.buttonType,
      blockButton: widget.blockBtton,
      fullWidthButton: widget.fullButton,
      size: widget.buttonSize,
      shape: widget.buttonShape,
      color: widget.buttonColor,
      textColor: widget.textColor,
      icon: widget.faIcon,
    );
  }
}

class VFIconButton extends StatefulWidget {
  //按钮样式
  final double buttonSize; //按钮尺寸
  final Color buttonColor; //按钮颜色
  final GFButtonType buttonType; //按钮样式
  final GFIconButtonShape buttonShape; //按钮边框圆角
  final FaIcon faIcon; //按钮图标设置

  //按钮布局
  //blockBtton/fullWidthButton只能二选一
  final bool blockBtton; //是否启用占满容器

  //按钮交互
  final VoidCallback onPressed; //按下按钮调用的函数

  const VFIconButton({
    Key? key,
    this.buttonColor = Colors.blueAccent,
    this.buttonSize = GFSize.LARGE,
    this.buttonType = GFButtonType.solid,
    this.buttonShape = GFIconButtonShape.standard,
    this.blockBtton = false,
    required this.onPressed,
    required this.faIcon,
  }) : super(key: key);
  @override
  State<VFIconButton> createState() => _VFIconButtonState();
}

class _VFIconButtonState extends State<VFIconButton> {
  @override
  Widget build(BuildContext context) {
    return GFIconButton(
      onPressed: widget.onPressed,
      type: widget.buttonType,
      size: widget.buttonSize,
      shape: widget.buttonShape,
      color: widget.buttonColor,
      icon: widget.faIcon,
    );
  }
}
