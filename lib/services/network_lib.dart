// 取消命名检查
// ignore_for_file: non_constant_identifier_names, constant_identifier_names
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ventroar_app/functions/vent_snack.dart';
import '../schemas/user.dart';
import './vent_apis.dart';

//自定配置信息类
class DioOptions {
  static String BASIC_URL = VentUrls.apiPath; //基础url地址
  static const int CONNECT_TIMEOUT = 6 * 1000; //连接超时时间
  static const int RECEIVE_TIMEOUT = 6 * 1000; //响应超时时间
  static const bool CACHE_ENABLE = false; //是否开启网络缓存,默认false
  static int MAX_CACHE_AGE = 7 * 24 * 60 * 60; //最大缓存存在期限(按秒),默认缓存七天,可看情况自定
  static int MAX_CACHE_COUNT = 100; //最大缓存条数,默认100条
}

//简单的自定义拦截器
class CustomInterceptors extends Interceptor {
  @override
  //请求之前
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('请求之前');
    print('REQUEST[${options.method}] => PATH: ${options.path}');
    return super.onRequest(options, handler);
  }

  @override
  //响应之后
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('响应之后');
    print(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    print('datas: ${response.data}');
    vSnackBar(
      model: VSnackModel.success,
      textWidget: Text(
        response.data["msg"],
        style: TextStyle(
            fontSize: 17.sp, color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
    return super.onResponse(response, handler);
  }

  @override
  //发生异常时
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print('发生异常');
    print(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    print('ERROR-MESSAGE => [${err.response?.data["msg"]}]');
    vSnackBar(
      showTime: const Duration(seconds: 60),
      model: VSnackModel.error,
      textWidget: ListView(
        children: [
          Text(
            err.response?.data["msg"],
            style: TextStyle(
                fontSize: 17.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );

    return super.onError(err, handler);
  }
}

//服务总类(基类、父类)
class Services {
  //全局Dio实例
  static final Services instance = Services._init();
  static Dio? _dio;
  Services._init();

  Future<Dio> get dio async {
    //设置基本配置信息
    var options = BaseOptions(
      //连接超时时间
      connectTimeout: DioOptions.CONNECT_TIMEOUT,
      //响应超时时间
      receiveTimeout: DioOptions.RECEIVE_TIMEOUT,
      //响应数据类型
      responseType: ResponseType.json,
      //默认url地址
      baseUrl: VentUrls.apiPath,
      //头部配置信息
      // headers: /// 自定义Header
    );

    //设置自定义网络拦截器配置
    Dio a = Dio(options);
    a.interceptors.add(CustomInterceptors());
    //检查静态变量dio是否存在
    //如果存在就返回已有的dio
    //如果不存在就创建新的dio实例返回
    return _dio ?? a;
  }

  /// 清空全局dio对象
  void close() {
    _dio != null ? _dio!.close() : _dio = null;
  }
}

class RoarHttpLib {}

class UserHttpLib {
  Future<Map> signIn(
      {required Map<String, dynamic> data, required Box<User> box}) async {
    Response response;
    response = await Services.instance.dio
        .then((value) => value.post(VentUrls.signIn, data: data));

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

  Future<Map> tokenLogin(
      {required Map<String, dynamic> data,
      required String token,
      required Box<User> box}) async {
    Response response;

    response = await Services.instance.dio.then((value) => value.post(
          VentUrlsTest.signIn,
          data: data,
          options: Options(
            headers: {"x-auth-token": token},
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
            authToken: response.data["result"]["authToken"],
            isOnline: response.data["result"]["isOnline"],
            isAdmin: response.data["result"]["isAdmin"],
          ));
      return response.data;
    }
    return {"msg": "tokenLogin network error!!!"};
  }

  Future<Map> signUp({required Map<String, dynamic> data}) async {
    Response response;
    response = await Services.instance.dio
        .then((value) => value.post(VentUrlsTest.signUp, data: data));
    return response.data;
  }

  void signOut() {}
}
