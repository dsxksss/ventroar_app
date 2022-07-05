// 取消命名检查
// ignore_for_file: non_constant_identifier_names, constant_identifier_names
import 'package:dio/dio.dart';

//自定url地址配置类
class VentUrls {
  static String apiPath = "https://ventroar.xyz:2546/";
  static String userDataApi = "${apiPath}userDataApi/"; //只用于获得用户数据、不提供其他权限
  static String roarDataApi = "${apiPath}textDataApi/"; //只用于获得发泄墙数据、不提供其他权限
  static String userCreateApi = "${apiPath}userCreateApi/"; //只允许用户创建数据,不提供其他权限
  static String userLoginApi =
      "${apiPath}userLoginApi/"; //只允许验证用户创建后的数据,不提供其他权限
  static String userTextApi = "${apiPath}userTextApi/"; //用户提交发泄墙类型等功能的一个集合
}

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
    // print('datas: ${response.data}');
    return super.onResponse(response, handler);
  }

  @override
  //发生异常时
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print('发生异常');
    print(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    return super.onError(err, handler);
  }
}

abstract class HttpMethod<T> {
  Future<T> getListData({String? url});
  //TODO: 待完成剩余http请求方法...
}

//服务总类(基类、父类)
class Services implements HttpMethod {
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
    var interceptorsWrapper = CustomInterceptors();
    Dio a = Dio(options);
    a.interceptors.add(interceptorsWrapper);

    //检查静态变量dio是否存在
    //如果存在就返回已有的dio
    //如果不存在就创建新的dio实例返回
    return _dio ?? a;
  }

  /// 清空全局dio对象
  static clear() {
    _dio = null;
  }

  Map<String, dynamic> responseFactory(Map<String, dynamic> dataMap) {
    //TODO:对请求结果进行加工
    return dataMap;
  }

  String errorFactory(DioError error) {
    // 请求错误处理
    String errorMessage = error.message;
    /*
    TODO:具体的错误处理
    */
    return errorMessage;
  }

  @override
  Future<List> getListData({String? url}) async {
    return [];
  }
}

class BasicHttpLib implements HttpMethod {
  @override
  Future<List> getListData({String? url}) async {
    Response response;
    response = await Services.instance.dio
        .then((value) => value.get(url ?? VentUrls.roarDataApi));
    return response.data as List<dynamic>;
  }
}

// class RoarHttpLib implements HttpMethod {
//   static RoarHttpLib instance = RoarHttpLib();
// }

// class UserHttpLib implements HttpMethod {
//   static UserHttpLib instance = UserHttpLib();
// }
