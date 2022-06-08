import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class StarPage extends StatefulWidget {
  const StarPage({Key? key}) : super(key: key);

  @override
  State<StarPage> createState() => _StarPageState();
}

class _StarPageState extends State<StarPage> {
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
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Text(
            "星墙页面",
            style: TextStyle(fontSize: 30),
          ),
          Text(
            "(制作中)...",
            style: TextStyle(fontSize: 26),
          )
        ],
      ),
    );
  }
}
