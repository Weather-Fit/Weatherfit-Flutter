import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherfit/Calendar/View/CalendarView.dart';
import 'package:weatherfit/main.dart';

import '../../Util/auth_service.dart';
import '../../Util/calendar_service.dart';
import '../../app_theme.dart';
import '../Model/CalendarModel.dart';

class RecordView extends StatefulWidget {
  const RecordView({Key? key}) : super(key: key);

  @override
  State<RecordView> createState() => _RecordViewState();
}

class _RecordViewState extends State<RecordView> {
  TextEditingController textController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  final List<String> _imagePaths = [
    'asset/images/img_hoodie_black.png',
    'asset/images/img_hoodie_grey.png',
    'asset/images/img_moostang.png',
    'asset/images/img_padding_black.png',
    'asset/images/img_ops_black.png',
    'asset/images/img_ops_pink.png',
    'asset/images/img_padding_navy.png',
    'asset/images/img_vest_grey.png',
    'asset/images/img_shirt_sora.png',
  ];

  @override
  Widget build(BuildContext context) {
    final authService = context.read<AuthService>();
    final user = authService.currentUser()!;
    return Consumer<RecordService>(
      builder: (context, recordService, child) {
        return Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 100),
                Text(
                  "코디와 어울리는 아이콘을 선택하세요.",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w600,
                    color: AppTheme().lightTheme.colorScheme.tertiary,
                  ),
                ),
                ImageGrid(
                  imagePaths: _imagePaths,
                  imageController: imageController,
                ),
                SizedBox(height: 10),
                TextField(
                  controller: textController,
                  decoration: InputDecoration(
                    hintText: "코디를 작성해주세요.",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 32),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: AppTheme().lightTheme.colorScheme.tertiary,
                  ),
                  onPressed: () {
                    if (textController.text.isNotEmpty &&
                        imageController.text.isNotEmpty) {
                      recordService.create(textController.text,
                          imageController.text, user.uid, selectedDate);
                    }
                    Navigator.pop(context);
                  },
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

class ImageGrid extends StatelessWidget {
  final List<String> imagePaths;
  final TextEditingController imageController;

  ImageGrid({required this.imagePaths, required this.imageController});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
        ),
        itemCount: imagePaths.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: Image.asset(imagePaths[index]),
            onTap: () {
              imageController.text = imagePaths[index];
            },
          );
        },
      ),
    );
  }
}
