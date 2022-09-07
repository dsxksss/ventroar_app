import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../schemas/roar.dart';
import '../schemas/user.dart';
import 'network_lib.dart';
import 'vent_apis.dart';

class RoarHttpLib {
  Future<Map> getAllRoarText({required Box<List<dynamic>> box}) async {
    Response response;
    response = await Services.instance.dio
        .then((value) => value.get(VentUrls.getAllRoarText));
    if (response.statusCode == 200) {
      int count = response.data["result"].length ?? 0;
      List<Roar> roars = [];
      for (int i = 0; i < count; i++) {
        roars.add(Roar(
          id: response.data["result"][i]["_id"],
          text: response.data["result"][i]["text"],
          isPublic: null,
          isShowUserName: response.data["result"][i]["isShowUserName"],
          isCanComment: response.data["result"][i]["isCanComment"],
          likeUsers: response.data["result"][i]["likeUsers"],
          textImages: response.data["result"][i]["textImages"],
          textComments: null,
          textCommentCount: response.data["result"][i]["textCommentCount"],
          createDate: response.data["result"][i]["createDate"],
          smil: response.data["result"][i]["smil"],
          heart: response.data["result"][i]["heart"],
          userId: response.data["result"][i]["userId"],
          userName: response.data["result"][i]["userName"],
          userEmail: response.data["result"][i]["userEmail"],
          userAvatarUrl: response.data["result"][i]["userAvatarUrl"],
        ));
      }
      box.put("homePageRoars", roars);
      return {"data": roars, "statusCode": response.statusCode};
    }
    return {
      "msg": "getAllRoarText network error!!!",
      "statusCode": response.statusCode
    };
  }

  Future<Map> clickTextLikes({
    required Map<String, dynamic> data,
  }) async {
    User? user = Services.instance.my;
    if (user == null || user.authToken.isEmpty || user.authToken.length < 8) {
      return {"msg": "error authToken is empty!!!", "statusCode": 400};
    }
    Response response;
    response = await Services.instance.dio.then((value) => value.put(
          VentUrls.clickTextLikes,
          data: data,
          options: Options(
            headers: {"x-auth-token": user.authToken},
          ),
        ));
    if (response.statusCode == 200) {
      return {
        "headers": response.headers,
        "data": response.data,
        "statusCode": response.statusCode
      };
    }
    return {
      "msg": "clickTextLikes network error!!!",
      "statusCode": response.statusCode
    };
  }
}
