import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

import '../contexts/global_provider.dart';
import '../functions/vent_snack.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _accountController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    bool _isLoginState =
        Provider.of<UserVerificationProvider>(context).isLoginState;
    final Function _loginIn =
        Provider.of<UserVerificationProvider>(context).loginIn;
    String _loginToken =
        Provider.of<UserVerificationProvider>(context).nowLoginToken;

    Future login() async {
      try {
        Response _response;
        var dio = Dio();
        _response =
            await dio.post("https://ventroar.xyz:2546/userLoginApi/", data: {
          "userPhoneNumber": _accountController.text,
          "userPassword": _passwordController.text,
        });
        // print(_response);//登录时间
        print(_response.headers["x-auth-token"]);
        _loginIn(_response.headers["x-auth-token"]![0]);
        vSnackBar(
          context: context,
          model: VSnackModel.success,
          textWidget: Text(
            "登录成功",
            style: TextStyle(fontSize: 15.sp, color: Colors.white),
          ),
          showTime: const Duration(milliseconds: 1400),
        );
        Future.delayed(
          const Duration(seconds: 1),
          () => {
            Navigator.of(context)
                .pushNamedAndRemoveUntil("./", (route) => false)
          },
        );
      } on DioError catch (e) {
        if (e.response?.statusCode == 400) {
          vSnackBar(
            context: context,
            model: VSnackModel.error,
            textWidget: Text(
              "账号或密码错误,请重试!",
              style: TextStyle(fontSize: 15.sp, color: Colors.white),
            ),
          );
        } else {
          vSnackBar(
            context: context,
            model: VSnackModel.error,
            textWidget: Text(
              "网络繁忙,登录失败,请重试...",
              style: TextStyle(fontSize: 15.sp, color: Colors.white),
            ),
          );
        }
      }
    }

    Future autoLogin() async {
      try {
        var dio = Dio();
        await dio.post(
          "https://ventroar.xyz:2546/userLoginApi/autoLogin",
          options: Options(
            headers: {"x-auth-token": _loginToken},
          ),
        );
        Future.delayed(
          const Duration(milliseconds: 1000),
          () => {
            vSnackBar(
              context: context,
              model: VSnackModel.success,
              textWidget: Text(
                "自动登录~",
                style: TextStyle(fontSize: 15.sp, color: Colors.white),
              ),
              showTime: const Duration(milliseconds: 1400),
            ),
            Navigator.of(context)
                .pushNamedAndRemoveUntil("./", (route) => false)
          },
        );
      } on DioError catch (e) {
        print(e.message);
        if (e.response?.statusCode == 400) {
          vSnackBar(
            context: context,
            model: VSnackModel.warning,
            textWidget: Text(
              "自动登录失败!",
              style: TextStyle(fontSize: 15.sp, color: Colors.white),
            ),
          );
        } else {
          vSnackBar(
            context: context,
            model: VSnackModel.error,
            textWidget: Text(
              "网络繁忙,自动登录失败,请重试",
              style: TextStyle(fontSize: 15.sp, color: Colors.white),
            ),
          );
        }
      }
    }

    Future.delayed(
      const Duration(milliseconds: 1500),
      () => {
        if (_isLoginState) {autoLogin()}
      },
    );

    return Builder(builder: (context) {
      bool _isDark = Provider.of<ThemeProvider>(context, listen: true).isDark;
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: Scaffold(
          body: Container(
            color: Theme.of(context).canvasColor,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: _isLoginState
                  ? Center(
                      child: _isDark
                          ? Container(
                              color: Theme.of(context)
                                  .appBarTheme
                                  .foregroundColor!
                                  .withOpacity(0),
                              width: 200,
                              height: 200,
                              child: const RiveAnimation.asset(
                                  'static/animations/dark/wait_d.riv'),
                            )
                          : const SizedBox(
                              width: 200,
                              height: 200,
                              child: RiveAnimation.asset(
                                  'static/animations/light/wait_l.riv'),
                            ),
                    )
                  : SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width * 0.70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextFormField(
                            controller: _accountController,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(
                                FontAwesomeIcons.solidUser,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 0.03.sh,
                          ),
                          TextFormField(
                            controller: _passwordController,
                            decoration: const InputDecoration(
                              isDense: false,
                              prefixIcon: Icon(
                                FontAwesomeIcons.lock,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              login();
                            },
                            child: const Text("Login"),
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        ),
      );
    });
  }
}
