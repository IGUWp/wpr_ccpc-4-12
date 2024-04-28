import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:wpr_ccpc_4_12/http_request.dart';
import 'package:wpr_ccpc_4_12/navigation_home_screen.dart';
import 'package:wpr_ccpc_4_12/usermodel/user_riverpod.dart';

import '../usermodel/user.dart';

class SignInForm extends StatelessWidget {
  SignInForm({
    Key? key,
  }) : super(key: key);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(
    BuildContext context,
  ) {
    final userProvider = Provider.of<UserProvider>(context);
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "用户名",
            style: TextStyle(color: Colors.black54),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8, bottom: 16),
            child: TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: SvgPicture.asset("lib/sign/assets/icons/email.svg"),
                ),
              ),
            ),
          ),
          Text(
            "密码",
            style: TextStyle(color: Colors.black54),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8, bottom: 16),
            child: TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: SvgPicture.asset("lib/sign/assets/icons/password.svg"),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8, bottom: 24),
            child: ElevatedButton.icon(
              onPressed: () async {
                String email = emailController.text;
                String password = passwordController.text;
                Response response;
                User newUser;
                try {
                  response = await http.post(
                    "/User/UserLogin",
                    data: {"userName": email, "password": password, "role": 1},
                    // options: Options(
                    //   headers: {
                    //     "accept": "*/*",
                    //     "Content-Type": "application/json",

                    //   },
                    // ),
                  );
                  if (response.data['state'] == 200) {
                    var responseData = response.data;
                    // print(responseData['data']['userid']);
                    http.token = response.headers['jwt_token']?[0];
                    // print(http.token);
                    // 使用响应数据创建 User 对象
                    newUser = User(
                      userid: responseData['data']['userid'] ?? "",
                      username: responseData['data']['username'] ?? "",
                      nickname: responseData['data']['nickname'] ?? "",
                      role: responseData['data']['role'] ?? "",
                      emailaddress: responseData['data']['emailaddress'] ?? "",
                      phonenumber: responseData['data']['phonenumber'] ?? "",
                      avatarurl: responseData['data']['avatarurl'] ?? "",
                      resumeurl: responseData['data']['resumeurl'] ?? "",
                    );
                    userProvider.setUser(newUser);
                    print(newUser);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              NavigationHomeScreen()), // 替换TargetScreen为目标界面
                    );
                  } else {
                    // ignore: use_build_context_synchronously
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("登录失败"),
                          content: Text("请检查您的用户名和密码。"),
                          actions: <Widget>[
                            TextButton(
                              child: Text("关闭"),
                              onPressed: () {
                                // 当用户点击关闭按钮时，对话框消失
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                } catch (e) {
                  print(e);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFF77D8E),
                minimumSize: Size(double.infinity, 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                  ),
                ),
              ),
              icon: Icon(
                CupertinoIcons.arrow_right,
                color: Color(0xFFFE0037),
              ),
              label: Text("登录"),
            ),
          ),
        ],
      ),
    );
  }
}
