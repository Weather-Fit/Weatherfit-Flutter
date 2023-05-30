import 'package:flutter/material.dart';
import 'package:weatherfit/Record/View/RecordCloth.dart';

/// 세 번째 페이지
class ThirdPage extends StatelessWidget {
  const ThirdPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RecordCloth(),
      ),
    );
  }
}
