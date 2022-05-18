import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class VSlidable extends StatefulWidget {
  const VSlidable({Key? key}) : super(key: key);

  @override
  State<VSlidable> createState() => _VSlidableState();
}

class _VSlidableState extends State<VSlidable> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      /// 如果 Slidable 是可关闭的，则指定一个键
      key: const ValueKey(0),

      // 操作窗格位于左侧
      startActionPane: ActionPane(
        /// motion 是用于控制窗格动画方式的小部件
        /// DrawerMotion()
        /// BehindMotion()
        /// ScrollMotion()
        /// StretchMotion()
        motion: const StretchMotion(),

        // 当窗格可以关闭Slidable时。
        dismissible: DismissiblePane(onDismissed: () {}),

        // 选项都在 children 中定义。
        children: [
          // SlidableAction组件可以有一个图标或标签.
          SlidableAction(
            onPressed: (slidabContext) {},
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
          SlidableAction(
            onPressed: (slidabContext) {},
            backgroundColor: const Color(0xFF21B7CA),
            foregroundColor: Colors.white,
            icon: Icons.share,
            label: 'Share',
          ),
        ],
      ),

      // 操作窗格位于右侧
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            /// 此选项可占的位置
            /// 默认为 1
            flex: 1,
            onPressed: (slidabContext) {},
            backgroundColor: const Color(0xFF7BC043),
            foregroundColor: Colors.white,
            icon: Icons.archive,
            label: 'Archive',
          ),
          SlidableAction(
            onPressed: (slidabContext) {},
            backgroundColor: const Color(0xFF0392CF),
            foregroundColor: Colors.white,
            icon: Icons.save,
            label: 'Save',
          ),
        ],
      ),

      /// 当组件没有被拖动时
      child: const ListTile(
          title: Text(
        "SlidableList",
        style: TextStyle(color: Colors.white),
      )),
    );
  }
}
