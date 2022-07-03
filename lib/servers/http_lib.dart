// 取消命名检查
// ignore_for_file: non_constant_identifier_names, constant_identifier_names

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

class DioOptions {
  static const int CONNECT_TIMEOUT = 6 * 1000; //连接超时时间
  static const int RECEIVE_TIMEOUT = 6 * 1000; //响应超时时间
  static String BASIC_URL = VentUrls.apiPath; //响应超时时间
  static const bool CACHE_ENABLE = false; //是否开启网络缓存,默认false
  static int MAX_CACHE_AGE = 7 * 24 * 60 * 60; //最大缓存存在期限(按秒),默认缓存七天,可看情况自定
  static int MAX_CACHE_COUNT = 100; //最大缓存条数,默认100条
}

class BasicHttpLib {
  // factory BasicHttpLib() => _getInstance();
  // static BasicHttpLib get instance => _getInstance();
  // static BasicHttpLib _instance;
  // Dio get dio => _dio;

  // 声明Dio变量
  // Dio _dio;
  //取消请求token
  final CancelToken _cancelToken = CancelToken();

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
}
