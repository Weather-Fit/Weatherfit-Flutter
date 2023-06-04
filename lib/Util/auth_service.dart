import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:weatherfit/Login/Model/UserModel.dart';
import 'package:weatherfit/Util/calendar_service.dart';

class AuthService extends ChangeNotifier {
  User? currentUser() {
    // 현재 유저(로그인 되지 않은 경우 null 반환)
    RecordService.instance.user = FirebaseAuth.instance.currentUser;
    return FirebaseAuth.instance.currentUser;
  }

  void signUp({
    required UserModel user,
    required Function() onSuccess, // 가입 성공시 호출되는 함수
    required Function(String err) onError, // 에러 발생시 호출되는 함수
  }) async {
    // 회원가입
    // 이메일 및 비밀번호 입력 여부 확인
    if (user.email.isEmpty) {
      onError("이메일을 입력해 주세요.");
      return;
    } else if (user.password.isEmpty) {
      onError("비밀번호를 입력해 주세요.");
      return;
    }

    // firebase auth 회원 가입
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );

      // 성공 함수 호출
      onSuccess();
    } on FirebaseAuthException catch (e) {
      // Firebase auth 에러 발생
      onError(e.message!);
    } catch (e) {
      // Firebase auth 이외의 에러 발생
      onError(e.toString());
    }
  }

  void signIn({
    required UserModel user,
    required Function() onSuccess, // 로그인 성공시 호출되는 함수
    required Function(String err) onError, // 에러 발생시 호출되는 함수
  }) async {
    // 로그인
    if (user.email.isEmpty) {
      onError('이메일을 입력해주세요.');
      return;
    } else if (user.password.isEmpty) {
      onError('비밀번호를 입력해주세요.');
      return;
    }

    // 로그인 시도
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );
      RecordService.instance.user = FirebaseAuth.instance.currentUser;
      onSuccess(); // 성공 함수 호출
      notifyListeners(); // 로그인 상태 변경 알림
    } on FirebaseAuthException catch (e) {
      // firebase auth 에러 발생
      onError(e.message!);
    } catch (e) {
      // Firebase auth 이외의 에러 발생
      onError(e.toString());
    }
  }

  void signOut() async {
    // 로그아웃
    await FirebaseAuth.instance.signOut();
    notifyListeners(); // 로그인 상태 변경 알림
  }

  // 구글 로그인 요청하기
  void signnInWithGoogle({
    required Function() onSuccess,
    required Function(String err) onError,
  }) async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // 구글 로그인한 계정 정보 요청하기
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Firebase Authentication 연결
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // 로그인 시도
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);

      onSuccess(); // 성공 함수 호출
      //notifyListeners(); // 로그인 상태 변경 알림
    } on FirebaseAuthException catch (e) {
      // firebase auth 에러 발생
      onError(e.message!);
    } catch (e) {
      // Firebase auth 이외의 에러 발생
      onError(e.toString());
    }
  }
}
