import 'package:flutter/material.dart';

class VCheckBoxList extends StatefulWidget {
  final Widget title; //列表标题
  final Widget secondary; //列表次要内容
  final bool isCheck; //当前的按钮选中状态
  final Function onChanged; //按下按钮之后的事件
  final Color activeColor; //按钮框内颜色
  final Color checkColor; //按钮框内的箭头颜色
  const VCheckBoxList({
    Key? key,
    this.isCheck = false,
    required this.onChanged,
    required this.title,
    required this.secondary,
    required this.activeColor,
    required this.checkColor,
  }) : super(key: key);

  @override
  State<VCheckBoxList> createState() => _VCheckBoxListState();
}

class _VCheckBoxListState extends State<VCheckBoxList> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: widget.title,
      secondary: widget.secondary,
      //改变现实位置
      controlAffinity: ListTileControlAffinity.trailing,
      value: widget.isCheck,
      onChanged: (value) {
        widget.onChanged(value);
      },
      //选择框颜色
      activeColor: widget.activeColor,
      //选择箭头颜色
      checkColor: widget.checkColor,
    );
  }
}
