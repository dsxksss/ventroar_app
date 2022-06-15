import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class VSlidable extends StatefulWidget {
  final Widget widget;
  final Function(BuildContext)? onPressed;
  const VSlidable({Key? key, required this.widget, required this.onPressed})
      : super(key: key);

  @override
  State<VSlidable> createState() => _VSlidableState();
}

class _VSlidableState extends State<VSlidable> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      /// 如果 Slidable 是可关闭的，则指定一个键
      key: const ValueKey(0),

      // 操作窗格位于右侧
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: widget.onPressed,
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),

      /// 当组件没有被拖动时
      child: widget.widget,
    );
  }
}
