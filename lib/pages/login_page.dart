import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ventroar_app/widgets/wait_animation.dart';

import '../schemas/user.dart';
import '../functions/vent_snack.dart';
import '../global/global_context.dart';
import '../services/user_http_lib.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late Box<User> box;
  late User? _user;

  void getUserData() {
    _user = box.get("my");
  }

  @override
  void initState() {
    super.initState();
    box = Hive.box("userbox");
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController _accountController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final FocusNode _accountNode = FocusNode();
    final FocusNode _passwordNode = FocusNode();

    Future signIn() async {
      try {
        var response = await UserHttpLib().signIn(data: {
          "account": _accountController.text,
          "password": _passwordController.text,
        }, box: box);
        if (response["statusCode"] == 200) {
          Future.delayed(const Duration(milliseconds: 1000), () {
            //TODO:待实现网络登录等待反馈动画
            Navigator.of(context)
                .pushNamedAndRemoveUntil("/", (route) => false);
          });
          //在显示其他snackbar之前，先删除当前snackbar
          ScaffoldMessenger.of(NavigationService.navigatorKey.currentContext!)
              .removeCurrentSnackBar();
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

    Future tokenLogin() async {
      try {
        var response = await UserHttpLib().tokenLogin(box: box);
        if (response["statusCode"] == 200) {
          Future.delayed(const Duration(milliseconds: 200), () {
            Navigator.of(context)
                .pushNamedAndRemoveUntil("/", (route) => false);
          });
          //在显示其他snackbar之前，先删除当前snackbar
          ScaffoldMessenger.of(NavigationService.navigatorKey.currentContext!)
              .removeCurrentSnackBar();
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
        if (e.response?.statusCode == 400 || e.response == null) {
          box.delete("my");
          getUserData();
          setState(() {
            _user = null;
          });
        }
      }
    }

    tokenLogin();

    return Builder(builder: (context) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: Scaffold(
          body: Container(
            color: Theme.of(context).canvasColor,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: _user != null
                  ? const WaitAnimation(
                      width: 200,
                      height: 200,
                    )
                  : SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width * 0.70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextFormField(
                            autofocus: true,
                            controller: _accountController,
                            focusNode: _accountNode,
                            maxLength: 20,
                            //如果超过最大值后的显示效果
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
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
                            obscureText: true,
                            focusNode: _passwordNode,
                            controller: _passwordController,
                            maxLength: 20,
                            //如果超过最大值后的显示效果
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
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
                              if (_accountController.text.length >= 3 &&
                                  _passwordController.text.length >= 8) {
                                signIn();
                                _accountNode.unfocus();
                                _passwordNode.unfocus();
                              } else if (_accountController.text.isEmpty ||
                                  _passwordController.text.isEmpty) {
                                _accountNode.unfocus();
                                _passwordNode.unfocus();
                                vSnackBar(
                                  showTime: const Duration(seconds: 60),
                                  model: VSnackModel.error,
                                  textWidget: Text(
                                    "账号或密码不能为空!",
                                    style: TextStyle(
                                        fontSize: 17.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                );
                              }
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
