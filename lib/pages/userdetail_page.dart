import 'package:flutter/material.dart';

class UserDetailPage extends StatefulWidget {
  final String titleText;
  const UserDetailPage({Key? key, required this.titleText}) : super(key: key);

  @override
  State<UserDetailPage> createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.titleText),
      ),
      body: Container(
        color: Theme.of(context).backgroundColor,
        height: double.infinity,
        width: double.infinity,
        child: const Center(
          child: Text(
            "用户详细信息页面",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
