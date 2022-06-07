import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:ventroar_app/functions/vent_snack.dart';

class StarPage extends StatefulWidget {
  const StarPage({Key? key}) : super(key: key);

  @override
  State<StarPage> createState() => _StarPageState();
}

class _StarPageState extends State<StarPage> {
  List<dynamic> userDataList = [];
  List<dynamic> textDataList = [];

  Future getData() async {
    Response response1;
    Response response2;
    var dio = Dio();
    response1 = await dio.get('https://ventroar.xyz:2546/userDataApi/');
    response2 = await dio.get('https://jsonplaceholder.typicode.com/comments/');
    setState(() {
      userDataList = response1.data;
      textDataList = response2.data;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return userDataList.isEmpty && textDataList.isEmpty
        ? Center(
            child: LoadingAnimationWidget.stretchedDots(
              color: Colors.blue.shade400,
              size: 60,
            ),
          )
        : RefreshIndicator(
            onRefresh: () {
              Fluttertoast.showToast(
                msg: "刷新屏幕",
                backgroundColor: Colors.blueAccent,
                gravity: ToastGravity.BOTTOM,
                toastLength: Toast.LENGTH_LONG,
                fontSize: 18,
              );
              return getData();
            },
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(3, 10, 3, 10),
              itemCount: userDataList.length,
              itemBuilder: (context, index) => Card(
                child: ListTile(
                  onTap: () => {
                    vSnackBar(
                      context: context,
                      textWidget: Text(
                        textDataList[Random().nextInt(50)]["name"].toString(),
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  },
                  minLeadingWidth: 10,
                  contentPadding: const EdgeInsets.fromLTRB(10, 0, 15, 0),
                  leading: CircleAvatar(
                    radius: 28,
                    foregroundImage: NetworkImage(
                        "https://api.lorem.space/image/face?hash=$index"),
                  ),
                  title: Text(
                      "User ${index + 1}: ${userDataList[Random().nextInt(15)]["userName"].toString()}"),
                  subtitle: textDataList.length <= index
                      ? const Text("whit......")
                      : Text(
                          "Eamil: ${textDataList[Random().nextInt(50)]["email"].toString()}"),
                  trailing: const Icon(Icons.arrow_forward),
                ),
              ),
            ),
          );
  }
}
