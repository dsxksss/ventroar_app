import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<dynamic> datalist = [];

  Future getData() async {
    Response response;
    var dio = Dio();
    response = await dio.get('https://ventroar.xyz:2546/textDataApi/');
    setState(() {
      datalist = response.data;
    });
    // Fluttertoast.showToast(
    //   msg: "刷新屏幕",
    //   backgroundColor: Colors.blueAccent,
    //   gravity: ToastGravity.BOTTOM,
    //   toastLength: Toast.LENGTH_LONG,
    //   fontSize: 20,
    // );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return getData();
      },
      child: ListView(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(20, 50, 20, 0),
            child: const Text("聊天页面"),
          ),
        ],
      ),
    );
  }
}
