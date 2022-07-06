import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

    Future login() async {
      try {
        Response response;
        var dio = Dio();
        _accountController.text;
        response =
            await dio.post("https://ventroar.xyz:2546/userLoginApi/", data: {
          "userPhoneNumber": _accountController.text,
          "userPassword": _passwordController.text,
        });
        print(response);
        print(response.headers["x-auth-token"]);
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

    return Builder(builder: (context) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: Scaffold(
          body: Container(
            color: Theme.of(context).canvasColor,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: SizedBox(
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
