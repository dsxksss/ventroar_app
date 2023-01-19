import 'vent_apis.dart';
import 'network_lib.dart';
import '../schemas/user.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UserHttpLib {
  Future<Map> signIn({
    required String account,
    required String password,
    required Box<User> box,
  }) async {
    Response response;
    response = await Services.instance.dio
        .then((value) => value.post(VentUrlsTest.signIn, data: {
              "account": account,
              "password": password,
            }));

    if (response.statusCode == 200) {
      box.put(
          "my",
          User(
            id: response.data["result"]["_id"],
            name: response.data["result"]["name"],
            email: response.data["result"]["email"],
            friends: response.data["result"]["friends"],
            inBox: response.data["result"]["inBox"],
            createDate: response.data["result"]["createDate"],
            avatarUrl: response.data["result"]["avatarUrl"],
            authToken: response.data["result"]["authToken"],
            isOnline: response.data["result"]["isOnline"],
            isAdmin: response.data["result"]["isAdmin"],
          ));
      return {
        "headers": response.headers,
        "data": response.data,
        "statusCode": response.statusCode
      };
    }
    return {"msg": "login network error!!!", "statusCode": response.statusCode};
  }

  Future<Map> tokenLogin({
    required Box<User> box,
  }) async {
    User? user = box.get("my");
    if (user == null || user.authToken.isEmpty || user.authToken.length < 8) {
      return {"msg": "error authToken is empty!!!", "statusCode": 400};
    }

    Response response;
    response = await Services.instance.dio.then((value) => value.post(
          VentUrlsTest.tokenLogin,
          options: Options(
            headers: {"x-auth-token": user.authToken},
          ),
        ));
    if (response.statusCode == 200) {
      box.put(
          "my",
          User(
            id: response.data["result"]["_id"],
            name: response.data["result"]["name"],
            email: response.data["result"]["email"],
            friends: response.data["result"]["friends"],
            inBox: response.data["result"]["inBox"],
            createDate: response.data["result"]["createDate"],
            avatarUrl: response.data["result"]["avatarUrl"],
            authToken: user.authToken,
            isOnline: response.data["result"]["isOnline"],
            isAdmin: response.data["result"]["isAdmin"],
          ));
      return {"data": response.data, "statusCode": response.statusCode};
    }
    return {
      "msg": "SignIn network error!!!",
      "statusCode": response.statusCode
    };
  }

  //TODO:signUp未实现
  Future<Map> signUp({required Map<String, dynamic> data}) async {
    Response response;
    response = await Services.instance.dio
        .then((value) => value.post(VentUrlsTest.signUp, data: data));
    if (response.statusCode == 202) {
      return {"data": response.data, "statusCode": response.statusCode};
    }
    return {
      "msg": "SignUp network error!!!",
      "statusCode": response.statusCode
    };
  }

  //TODO:signOut未实现
  Future<Map> signOut({required String token}) async {
    Response response;
    response = await Services.instance.dio.then(
      (value) => value.post(
        VentUrlsTest.signOut,
        options: Options(
          headers: {"x-auth-token": token},
        ),
      ),
    );
    if (response.statusCode == 200) {
      return {"data": response.data, "statusCode": response.statusCode};
    }
    return {
      "msg": "SignUp network error!!!",
      "statusCode": response.statusCode
    };
  }
}
