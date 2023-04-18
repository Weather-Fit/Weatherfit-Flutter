import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherfit/Signup/View/SignupView.dart';
import '../../auth_service.dart';
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
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                  Color.fromARGB(255, 95, 171, 233),
                  Color.fromARGB(255, 197, 234, 255)
                ])),
            alignment: Alignment.center,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "WeatherFit",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 32),

                  /// 이메일
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(hintText: "e-mail"),
                  ),

                  /// 비밀번호
                  TextField(
                    controller: passwordController,
                    obscureText: true, // 비밀번호 안보이게
                    decoration: InputDecoration(hintText: "password"),
                  ),
                  SizedBox(height: 32),

                  /// 로그인 버튼
                  ElevatedButton(
                    child: Text("Login", style: TextStyle(fontSize: 21)),
                    onPressed: () {
                      // 로그인
                      authService.signIn(
                        email: emailController.text,
                        password: passwordController.text,
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
                    child: Text("Sign up", style: TextStyle(fontSize: 21)),
                    onPressed: () {
                      // 회원가입 화면으로 이동
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignupView()),
                      );
                    },
                  ),

                  /// 구글 계정으로 로그인 버튼
                  ElevatedButton(
                    child: Text("Sign In with Google",
                        style: TextStyle(fontSize: 21)),
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
//https://mike123789-dev.tistory.com/entry/%ED%94%8C%EB%9F%AC%ED%84%B0-20-%EB%B2%84%ED%8A%BC-1-TextButton-ElevatedButton-OutlinedButton-IconButton-ButtonBar


/*class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginViewModel(),
      child: Scaffold(
        appBar: AppBar(title: Text('Weatherfit')),
        body: _LoginView(),
      ),
    );
  }
}

class _LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<LoginViewModel>(context);

    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'Weatherfit',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200.0,
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: viewModel.isLoginDataValid
                        ? () async {
                            final success = await viewModel.login();
                            if (success) {
                              // 로그인 성공 시 다음 페이지로 이동
                              /*
                              Navigator.push(
                                BottomNavigationBarWidget()
                              );
                              */
                              print('로그인 성공');
                            } else {
                              // 로그인 실패 시 에러 메시지 표시
                            }
                          }
                        : null,
                    child: Text(
                      'Google Login',
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}*/

