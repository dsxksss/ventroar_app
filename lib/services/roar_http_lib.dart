import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'network_lib.dart';
import 'vent_apis.dart';

import '../schemas/user.dart';
import '../schemas/roar.dart';

class RoarHttpLib {
  Future<Map> getAllRoarText({required Box<Roar> box}) async {
    Response response;
    response = await Services.instance.dio
        .then((value) => value.get(VentUrlsTest.getAllRoarText));
    if (response.statusCode == 200) {
      //获取新数据前先清理老数据
      box.deleteAll(box.values.map((e) => e.id));
      List<dynamic> sortData = response.data["result"];
      for (dynamic s in sortData) {
        box.put(
          s["_id"],
          Roar(
            id: s["_id"],
            text: s["text"],
            isPublic: null,
            isShowUserName: s["isShowUserName"],
            isCanComment: s["isCanComment"],
            smilLikeUsers: s["smilLikeUsers"],
            heartLikeUsers: s["heartLikeUsers"],
            textImages: s["textImages"],
            textComments: s["textComments"],
            textCommentCount: s["textCommentCount"],
            createDate: s["createDate"],
            smil: s["smil"],
            heart: s["heart"],
            userId: s["userId"],
            userName: s["userName"],
            userEmail: s["userEmail"],
            userAvatarUrl: s["userAvatarUrl"],
          ),
        );
      }
      return {"statusCode": response.statusCode};
    }
    return {
      "msg": "getAllRoarText network error!!!",
      "statusCode": response.statusCode
    };
  }

  Future<Map> clickTextLikes({
    required String likeId,
    required String likeWho,
  }) async {
    User? user = Services.instance.my;
    if (user == null || user.authToken.isEmpty || user.authToken.length < 8) {
      return {"msg": "error authToken is empty!!!", "statusCode": 400};
    }
    Response response;
    response = await Services.instance.dio.then((value) => value.put(
          VentUrlsTest.clickTextLikes,
          data: {
            "textId": likeId,
            "likeWho": likeWho,
          },
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

  Future<Map> deleteRoarText({
    required String deleteId,
  }) async {
    User? user = Services.instance.my;
    if (user == null || user.authToken.isEmpty || user.authToken.length < 8) {
      return {"msg": "error authToken is empty!!!", "statusCode": 400};
    }
    Response response;
    response = await Services.instance.dio.then((value) => value.delete(
          VentUrlsTest.deleteRoarText,
          data: {"id": deleteId},
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
    return {"msg": "delete failed!!!", "statusCode": response.statusCode};
  }

  Future<Map> postRoarText({
    required Box<Roar> box,
    required String text,
    required bool isPublic,
    required bool isShowUserName,
    required bool isCanComment,
  }) async {
    User? user = Services.instance.my;
    if (user == null || user.authToken.isEmpty || user.authToken.length < 8) {
      return {"msg": "error authToken is empty!!!", "statusCode": 400};
    }
    Response response;
    response = await Services.instance.dio.then((value) => value.post(
          VentUrlsTest.postRoarText,
          data: {
            "text": text,
            "isPublic": isPublic,
            "isShowUserName": isShowUserName,
            "isCanComment": isCanComment,
          },
          options: Options(
            headers: {"x-auth-token": user.authToken},
          ),
        ));
    if (response.statusCode == 200) {
      if (response.data["result"]["isPublic"]) {
        box.put(
          response.data["result"]["_id"],
          Roar(
            id: response.data["result"]["_id"],
            text: response.data["result"]["text"],
            isPublic: null,
            isShowUserName: response.data["result"]["isShowUserName"],
            isCanComment: response.data["result"]["isCanComment"],
            smilLikeUsers: response.data["result"]["smilLikeUsers"],
            heartLikeUsers: response.data["result"]["heartLikeUsers"],
            textImages: response.data["result"]["textImages"],
            textComments: response.data["result"]["textComments"],
            //刚发布的帖子不存在评论，所以这里填0
            textCommentCount: 0,
            createDate: response.data["result"]["createDate"],
            smil: response.data["result"]["smil"],
            heart: response.data["result"]["heart"],
            userId: response.data["result"]["userId"],
            //以下内容后端未返回，直接使用用户本地数据即可
            userName:
                response.data["result"]["isShowUserName"] ? user.name : "匿名者",
            userEmail:
                response.data["result"]["isShowUserName"] ? user.email : "匿名邮箱",
            userAvatarUrl: response.data["result"]["isShowUserName"]
                ? user.avatarUrl
                : "null",
          ),
        );
      }
      return {"data": response.data, "statusCode": response.statusCode};
    }
    return {
      "msg": "post RoarText failed!!!",
      "statusCode": response.statusCode
    };
  }

  Future<Map> postTextImages({
    Function(int count, int total)? onSendProgress,
    required Box<Roar> box,
    required String textId,
    required List<dynamic> files,
  }) async {
    User? user = Services.instance.my;
    if (user == null || user.authToken.isEmpty || user.authToken.length < 8) {
      return {"msg": "error authToken is empty!!!", "statusCode": 400};
    }
    Response response;
    response = await Services.instance.dio.then(
      (value) => value.post(
        "${VentUrlsTest.postTextImages}/$textId",
        data: FormData.fromMap({'images': files}),
        options: Options(
          headers: {"x-auth-token": user.authToken},
        ),
        onSendProgress: onSendProgress,
      ),
    );
    if (response.statusCode == 200) {
      box.put(
        response.data["result"]["_id"],
        Roar(
          id: response.data["result"]["_id"],
          text: response.data["result"]["text"],
          isPublic: null,
          isShowUserName: response.data["result"]["isShowUserName"],
          isCanComment: response.data["result"]["isCanComment"],
          smilLikeUsers: response.data["result"]["smilLikeUsers"],
          heartLikeUsers: response.data["result"]["heartLikeUsers"],
          textImages: response.data["result"]["textImages"],
          textComments: response.data["result"]["textComments"],
          //刚发布的帖子不存在评论，所以这里填0
          textCommentCount: 0,
          createDate: response.data["result"]["createDate"],
          smil: response.data["result"]["smil"],
          heart: response.data["result"]["heart"],
          userId: response.data["result"]["userId"],
          //以下内容后端未返回，直接使用用户本地数据即可
          userName:
              response.data["result"]["isShowUserName"] ? user.name : "匿名者",
          userEmail:
              response.data["result"]["isShowUserName"] ? user.email : "匿名邮箱",
          userAvatarUrl: response.data["result"]["isShowUserName"]
              ? user.avatarUrl
              : "null",
        ),
      );
      return {"data": response.data, "statusCode": response.statusCode};
    }
    return {"msg": "post images failed!!!", "statusCode": response.statusCode};
  }
}
