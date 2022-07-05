import 'package:flutter/material.dart';
import 'package:ventroar_app/services/http_lib.dart';

class StarPage extends StatefulWidget {
  const StarPage({Key? key}) : super(key: key);

  @override
  State<StarPage> createState() => _StarPageState();
}

class _StarPageState extends State<StarPage> {
  @override
  Widget build(BuildContext context) {
    void a() async {
      BasicHttpLib a = BasicHttpLib();
      List<dynamic> datalist = await a.getListData();
      print(datalist[0]);
    }

    a();
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "星墙页面",
            style: TextStyle(
                fontSize: 30,
                color: Theme.of(context).textTheme.bodyText1!.color),
          ),
          Text(
            "(制作中)...",
            style: TextStyle(
                fontSize: 26,
                color: Theme.of(context).textTheme.bodyText1!.color),
          )
        ],
      ),
    );
  }
}
