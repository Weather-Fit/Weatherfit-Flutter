import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherfit/Login/Model/UserModel.dart';
import 'package:weatherfit/Signup/View/SignupView.dart';
import 'package:weatherfit/app_theme.dart';
import '../../Util/auth_service.dart';
import '../../main.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(
      builder: (context, authService, child) {
        final user = authService.currentUser();

        return Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            alignment: Alignment.center,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Text(
                      "WeatherFit",
                      style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                        color: AppTheme().lightTheme.colorScheme.tertiary,
                      ),
                    ),
                  ),
                  SizedBox(height: 32),
                  Center(
                    child: Text(
                      "Record your outfit coordination\n   based on the temperature",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w100,
                          color: Colors.black),
                    ),
                  ),
                  SizedBox(height: 32),

                  /// 이메일
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: "e-mail"),
                  ),
                  SizedBox(height: 16),

                  /// 비밀번호
                  TextField(
                    controller: passwordController,
                    obscureText: true, // 비밀번호 안보이게
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: "Password"),
                  ),
                  SizedBox(height: 32),

                  /// 로그인 버튼
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: AppTheme().lightTheme.colorScheme.tertiary,
                    ),
                    child: Text("Login",
                        style: TextStyle(
                            fontSize: 21, fontWeight: FontWeight.w400)),
                    onPressed: () {
                      // 로그인
                      authService.signIn(
                        user: UserModel(
                            email: emailController.text,
                            password: passwordController.text),
                        onSuccess: () {
                          // 로그인 성공
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("로그인 성공"),
                          ));

                          // HomePage로 이동
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    BottomNavigationBarWidget()),
                          );
                        },
                        onError: (err) {
                          // 에러 발생
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(err),
                          ));
                        },
                      );
                    },
                  ),

                  /// 회원가입 버튼
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: AppTheme().lightTheme.colorScheme.tertiary,
                    ),
                    child: Text("Sign up",
                        style: TextStyle(
                            fontSize: 21, fontWeight: FontWeight.w400)),
                    onPressed: () {
                      // 회원가입 화면으로 이동
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignupView()),
                      );
                    },
                  ),
                  SizedBox(height: 16),

                  Center(
                    child: Text(
                      '---- or ----',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 15,
                        fontWeight: FontWeight.w100,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),

                  /// 구글 계정으로 로그인 버튼

                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      primary: AppTheme().lightTheme.colorScheme.tertiary,
                    ),
                    onPressed: () {
                      // 구글 계정으로 로그인
                      authService.signnInWithGoogle(
                        onSuccess: () {
                          // 로그인 성공
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("로그인 성공"),
                          ));

                          // HomePage로 이동
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    BottomNavigationBarWidget()),
                          );
                        },
                        onError: (err) {
                          // 에러 발생
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(err),
                          ));
                        },
                      );
                    },
                    icon: Image.asset(
                      'asset/images/ic_google.png',
                      width: 20,
                      height: 20,
                    ),
                    label: Text("Sign In with Google",
                        style: TextStyle(
                            fontSize: 21, fontWeight: FontWeight.w400)),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
