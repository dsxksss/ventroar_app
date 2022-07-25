import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:ventroar_app/widgets/wait_animation.dart';

import '../contexts/global_provider.dart';
import '../databases/user_db.dart';
import '../functions/vent_snack.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late Box<User> box;

  @override
  void initState() {
    super.initState();
    box = Hive.box("userbox");
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController _accountController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    Future login() async {
      try {
        Response _response;
        var dio = Dio();
        _response = await dio.post("https://ventroar.xyz:2548/signin/", data: {
          "account": _accountController.text,
          "password": _passwordController.text,
        });
        // print(_response);//登录时间
        // print(_response.headers["x-auth-token"]);
        context
            .read<UserVerificationProvider>()
            .loginIn(_response.headers["x-auth-token"]![0]);

        box.put(
          "myuser",
          User(
              id: _response.data["_id"],
              createDate: _response.data["createDate"],
              name: _response.data["name"],
              email: _response.data["email"],
              isOnline: _response.data["isOnline"],
              isAdmin: _response.data["isAdmin"],
              avatarUrl: _response.data["avatarUrl"]),
        );
        vSnackBar(
          context: this.context,
          model: VSnackModel.success,
          textWidget: Text(
            "登录成功",
            style: TextStyle(fontSize: 15.sp, color: Colors.white),
          ),
          showTime: const Duration(milliseconds: 1400),
        );
        Future.delayed(
            const Duration(seconds: 1),
            () => Navigator.of(context)
                .pushNamedAndRemoveUntil("./", (route) => false));
      } on DioError catch (e) {
        if (e.response?.statusCode == 400) {
          vSnackBar(
              context: this.context,
              model: VSnackModel.error,
              textWidget: Text(
                "账号或密码错误,请重试!",
                style: TextStyle(fontSize: 15.sp, color: Colors.white),
              ));
          Navigator.of(context)
              .pushNamedAndRemoveUntil("./login", (route) => false);
        } else {
          vSnackBar(
            context: this.context,
            model: VSnackModel.error,
            textWidget: Text(
              "网络繁忙,登录失败,请重试...",
              style: TextStyle(fontSize: 15.sp, color: Colors.white),
            ),
          );
          Navigator.of(context)
              .pushNamedAndRemoveUntil("./login", (route) => false);
        }
      }
    }

    Future autoLogin() async {
      try {
        if (!context.watch<UserVerificationProvider>().isLoginState) return;
        Response _response;
        var dio = Dio();
        _response = await dio.post(
          "https://ventroar.xyz:2548/tokenlogin",
          options: Options(
            headers: {
              "x-auth-token":
                  context.watch<UserVerificationProvider>().nowLoginToken
            },
          ),
        );
        box.put(
          "myuser",
          User(
              id: _response.data["_id"],
              createDate: _response.data["createDate"],
              name: _response.data["name"],
              email: _response.data["email"],
              isOnline: _response.data["isOnline"],
              isAdmin: _response.data["isAdmin"],
              avatarUrl: _response.data["avatarUrl"]),
        );
        Future.delayed(
          const Duration(milliseconds: 1000),
          () => {
            vSnackBar(
              context: this.context,
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
        if (e.response?.statusCode == 400) {
          vSnackBar(
            context: this.context,
            model: VSnackModel.warning,
            textWidget: Text(
              "自动登录失败!",
              style: TextStyle(fontSize: 15.sp, color: Colors.white),
            ),
          );
          context.read<UserVerificationProvider>().loginOut();
          Navigator.of(context)
              .pushNamedAndRemoveUntil("./login", (route) => false);
        } else {
          vSnackBar(
            context: this.context,
            model: VSnackModel.error,
            textWidget: Text(
              "网络繁忙,自动登录失败,请重试",
              style: TextStyle(fontSize: 15.sp, color: Colors.white),
            ),
          );
          context.read<UserVerificationProvider>().loginOut();
          Navigator.of(context)
              .pushNamedAndRemoveUntil("./login", (route) => false);
        }
      }
    }

    Future.delayed(
      const Duration(milliseconds: 1500),
      () => {
        if (context.read<UserVerificationProvider>().phoneLoginState!)
          {autoLogin()}
      },
    );
    return Builder(builder: (context) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: Scaffold(
          body: Container(
            color: Theme.of(context).canvasColor,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: context.watch<UserVerificationProvider>().isLoginState
                  ? const WaitAnimation()
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
