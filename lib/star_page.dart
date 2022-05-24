import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:getwidget/types/gf_button_type.dart';
import './widgets/vent_fbutton.dart';

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
    Fluttertoast.showToast(
      msg: "刷新屏幕",
      backgroundColor: Colors.blueAccent,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_LONG,
      fontSize: 20,
    );
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
            child: datalist.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...datalist.map(
                        (e) => VFTextIconButton(
                          fullButton: true,
                          buttonText: e["textData"].toString(),
                          onPressed: () {},
                          buttonShape: GFButtonShape.pills,
                          buttonType: GFButtonType.outline2x,
                          buttonColor: Colors.black12,
                          faIcon: const FaIcon(
                            FontAwesomeIcons.message,
                            color: Colors.black,
                          ),
                        ),
                      )
                    ],
                  )
                : const Text(
                    "试试往下划动屏幕～",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
