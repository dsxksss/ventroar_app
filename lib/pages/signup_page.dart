import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../functions/vent_snack.dart';
import '../services/user_http_lib.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  Future singnUp() async {
    try {
      var response = await UserHttpLib().signUp(data: {
        "name": "dsxk",
        "email": "3066556430@qq.com",
        "password": "123456789"
      });
      if (response["statusCode"] == 202) {
        //在显示其他snackbar之前，先删除当前snackbar
        vSnackBar(
          showTime: const Duration(seconds: 60),
          dismissDirection: DismissDirection.startToEnd,
          model: VSnackModel.info,
          isScroll: true,
          textWidget: Text(
            "已发送账户激活邮件,请查看注册邮箱激活再登录",
            style: TextStyle(
                fontSize: 17.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        );
      }
    } on DioError catch (e) {
      vSnackBar(
        showTime: const Duration(seconds: 60),
        dismissDirection: DismissDirection.startToEnd,
        model: VSnackModel.error,
        isScroll: e.type != DioErrorType.connectTimeout && e.response != null
            ? true
            : false,
        textWidget: Text(
          e.type == DioErrorType.connectTimeout
              ? "网络超时,请检查网络重试!"
              : e.response?.data["msg"] ?? "未连接网络,请检查后重试!",
          style: TextStyle(
              fontSize: 17.sp,
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
          icon: const Icon(Icons.recent_actors_outlined), onPressed: () {}),
    );
  }
}
