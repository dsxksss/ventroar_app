import 'package:dio/dio.dart';

class VentUrls {
  static String apiPath = "https://ventroar.xyz:2546/";
  static String userDataApi = "${apiPath}userDataApi/"; //只用于获得用户数据、不提供其他权限
  static String roarDataApi = "${apiPath}textDataApi/"; //只用于获得发泄墙数据、不提供其他权限
  static String userCreateApi = "${apiPath}userCreateApi/"; //只允许用户创建数据,不提供其他权限
  static String userLoginApi =
      "${apiPath}userLoginApi/"; //只允许验证用户创建后的数据,不提供其他权限
  static String userTextApi = "${apiPath}userTextApi/"; //用户提交发泄墙类型等功能的一个集合
}

class BasicHttpLib {
  static BasicHttpLib instance = BasicHttpLib();

  Future<List> getListData({required String url}) async {
    Response response;
    var dio = Dio();
    response = await dio.get(url);
    List<dynamic> a = response.data as List<dynamic>;
    return a;
  }
}

class RoarHttpLib extends BasicHttpLib {
  static RoarHttpLib instance = RoarHttpLib();
}

class UserHttpLib extends BasicHttpLib {
  static UserHttpLib instance = UserHttpLib();

  @override
  Future<List> getListData({required String url}) {
    return super.getListData(url: VentUrls.roarDataApi);
  }
}
