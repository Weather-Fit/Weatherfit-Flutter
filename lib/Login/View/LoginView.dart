import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherfit/Login/ViewModel/LoginViewModel.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginViewModel(),
      child: Scaffold(
        appBar: AppBar(title: Text('Login')),
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
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            onChanged: viewModel.setEmail,
            decoration: InputDecoration(labelText: 'Email'),
          ),
          SizedBox(height: 16.0),
          TextField(
            onChanged: viewModel.setPassword,
            decoration: InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
          SizedBox(height: 32.0),
          ElevatedButton(
            onPressed: viewModel.isLoginDataValid
                ? () async {
                    final success = await viewModel.login();
                    if (success) {
                      // 로그인 성공 시 다음 페이지로 이동
                      print('로그인 성공');
                    } else {
                      // 로그인 실패 시 에러 메시지 표시
                    }
                  }
                : null,
            child: Text('Login'),
          ),
        ],
      ),
    );
  }
}
