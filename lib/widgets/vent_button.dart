import 'package:flutter/material.dart';
//导入第三方外部getwidget库
import 'package:getwidget/getwidget.dart';

class VTextButton extends StatefulWidget {
  //按钮样式
  final String buttonText; //按钮文字
  final Color textColor; //按钮文字颜色
  final double buttonSize; //按钮尺寸
  final Color buttonColor; //按钮颜色
  final GFButtonType buttonType; //按钮样式
  final GFButtonShape buttonShape; //按钮边框圆角

  //按钮布局
  //blockBtton/fullWidthButton只能二选一
  final bool blockBtton; //是否启用占满容器
  final bool fullButton; //是否启用整宽按钮

  //按钮交互
  final VoidCallback onPressed; //按下按钮调用的函数

  const VTextButton({
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
  }) : super(key: key);
  @override
  State<VTextButton> createState() => _VTextButtonState();
}

class _VTextButtonState extends State<VTextButton> {
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
    );
  }
}

class VTextIconButton extends StatefulWidget {
  //按钮样式
  final String buttonText; //按钮文字
  final Color textColor; //按钮文字颜色
  final double buttonSize; //按钮尺寸
  final Color buttonColor; //按钮颜色
  final GFButtonType buttonType; //按钮样式
  final GFButtonShape buttonShape; //按钮边框圆角
  final Icon icon; //按钮图标设置

  //按钮布局
  //blockBtton/fullWidthButton只能二选一
  final bool blockBtton; //是否启用占满容器
  final bool fullButton; //是否启用整宽按钮

  //按钮交互
  final VoidCallback onPressed; //按下按钮调用的函数

  const VTextIconButton({
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
    required this.icon,
  }) : super(key: key);
  @override
  State<VTextIconButton> createState() => _VTextIconButtonState();
}

class _VTextIconButtonState extends State<VTextIconButton> {
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
      icon: widget.icon,
    );
  }
}

class VIconButton extends StatefulWidget {
  //按钮样式
  final double buttonSize; //按钮尺寸
  final Color buttonColor; //按钮颜色
  final GFButtonType buttonType; //按钮样式
  final GFIconButtonShape buttonShape; //按钮边框圆角
  final Icon icon; //按钮图标设置

  //按钮布局
  //blockBtton/fullWidthButton只能二选一
  final bool blockBtton; //是否启用占满容器

  //按钮交互
  final VoidCallback onPressed; //按下按钮调用的函数

  const VIconButton({
    Key? key,
    this.buttonColor = Colors.blueAccent,
    this.buttonSize = GFSize.LARGE,
    this.buttonType = GFButtonType.solid,
    this.buttonShape = GFIconButtonShape.standard,
    this.blockBtton = false,
    required this.onPressed,
    required this.icon,
  }) : super(key: key);
  @override
  State<VIconButton> createState() => _VIconButtonState();
}

class _VIconButtonState extends State<VIconButton> {
  @override
  Widget build(BuildContext context) {
    return GFIconButton(
      onPressed: widget.onPressed,
      type: widget.buttonType,
      size: widget.buttonSize,
      shape: widget.buttonShape,
      color: widget.buttonColor,
      icon: widget.icon,
    );
  }
}
