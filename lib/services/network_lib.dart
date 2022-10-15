// 取消命名检查
// ignore_for_file: non_constant_identifier_names, constant_identifier_names
import './vent_apis.dart';
import 'package:dio/dio.dart';
import '../schemas/user.dart';
import 'package:hive_flutter/hive_flutter.dart';

//自定配置信息类
class DioOptions {
  static String BASIC_URL = VentUrls.apiPath; //基础url地址
  static const int CONNECT_TIMEOUT = 30 * 1000; //连接超时时间
  static const int RECEIVE_TIMEOUT = 30 * 1000; //响应超时时间
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
    // print('REQUEST[${options.method}] => PATH: ${options.path}');
    return super.onRequest(options, handler);
  }

  @override
  //响应之后
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('响应之后');
    // print(
    //     'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    // print('datas: ${response.data}');
    // vSnackBar(
    //   model: VSnackModel.success,
    //   textWidget: Text(
    //     response.data["msg"],
    //     style: TextStyle(
    //         fontSize: 17.sp, color: Colors.white, fontWeight: FontWeight.bold),
    //   ),
    // );
    return super.onResponse(response, handler);
  }

  @override
  //发生异常时
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print('发生异常');
    print(err);
    print(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    // print('ERROR-MESSAGE => [${err.response?.data["msg"]}]');
    // print('ERROR-RESPONSE => [$err.response}]');
    // print('ERROR-HANDLER => [$handler}]');

    return super.onError(err, handler);
  }
}

//服务总类(基类、父类)
class Services {
  //全局Dio实例
  static final Services instance = Services._init();
  static Dio? _dio;
  static User? _my;
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

  User? get my {
    Box<User> box = Hive.box("userbox");
    User? a = box.get("my");
    return _my ?? a;
  }

  /// 清空全局dio对象
  void close() {
    _dio != null ? _dio!.close() : _dio = null;
  }
}
