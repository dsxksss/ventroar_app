import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:ventroar_app/widgets/wait_animation.dart';

import '../contexts/global_provider.dart';
import '../functions/vent_snack.dart';
import '../schemas/user.dart';
import '../services/network_lib.dart';

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
    Future signIn() async {
      UserHttpLib signin = UserHttpLib();
      var response = await signin.signIn(data: {
        "account": _accountController.text,
        "password": _passwordController.text,
      }, box: box);
      // _loginIn(_re.headers["x-auth-token"]![0]);
      if (response["statusCode"] == 200) {
        Navigator.of(context).pushNamedAndRemoveUntil("/", (route) => false);
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
                            obscureText: true,
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
                              if (_accountController.text.length >= 3 ||
                                  _passwordController.text.length >= 8) {
                                signIn();
                              } else if (_accountController.text.isEmpty ||
                                  _passwordController.text.isEmpty) {
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
