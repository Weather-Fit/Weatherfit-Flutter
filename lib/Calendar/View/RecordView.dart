import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherfit/Calendar/View/CalendarView.dart';

import '../../Util/auth_service.dart';
import '../Model/CalendarModel.dart';

class RecordView extends StatefulWidget {
  const RecordView({Key? key}) : super(key: key);

  @override
  State<RecordView> createState() => _RecordViewState();
}

class _RecordViewState extends State<RecordView> {
  TextEditingController recordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(
      builder: (context, authService, child) {
        return Scaffold(
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Text(
                    "추가",
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ),
                SizedBox(height: 32),

                /// 기록
                TextField(
                  controller: recordController,
                  decoration: InputDecoration(hintText: "코디를 작성해주세요."),
                ),

                ElevatedButton(
                  onPressed: addRecord(
                    user: CalendarModel(
                        userModel: userModel(),
                        record: recordController.text,
                        image: image),
                    onSuccess: () {
                      // 회원가입 성공
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CalendarView()),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Success!"),
                      ));
                    },
                  ),
                  child: Text("완료", style: TextStyle(fontSize: 21)),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

void addRecord({
  required CalendarModel user,
  required Function() onSuccess,
  required Function(String err) onError,
}) async {
  if (user.record.isEmpty) {
    onError("코디를 작성해주세요.");
    return;
  } else if (user.image.isEmpty) {
    onError("이미지를 선택해 주세요.");
    return;
  }
  final userReference = FirebaseDatabase().reference().child("User");
  userReference
      .child("userRecord")
      .set({"record": user.record, "img": user.image});
  onSuccess();
}



/*
 ElevatedButton(
                  child: Text("완료", style: TextStyle(fontSize: 21)),
                  onPressed: () {
                    // 회원가입
                    authService.signUp(
                      user: CalendarModel(
                          email: recordController.text,
                         
                      onSuccess: () {
                        // 회원가입 성공
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CalendarView()),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Success!"),
                        ));
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
 */