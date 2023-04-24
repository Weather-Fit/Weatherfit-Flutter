import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:weatherfit/app_theme.dart';

import '../calendar_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CalendarFormat calendarFormat = CalendarFormat.month;

  // 선택된 날짜
  DateTime selectedDate = DateTime.now();

  TextEditingController createTextController = TextEditingController();

  TextEditingController updateTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<RecordService>(
      builder: (context, recordService, child) {
        List<Record> diaryList = recordService.getByDate(selectedDate);
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Column(
              children: [
                TableCalendar(
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: selectedDate,
                  calendarFormat: calendarFormat,
                  onFormatChanged: (format) {
                    setState(() {
                      calendarFormat = format;
                    });
                  },
                  eventLoader: (date) {
                    return recordService.getByDate(date);
                  },
                  calendarStyle: CalendarStyle(
                    // today 색상 제거
                    todayTextStyle: TextStyle(color: Colors.black),
                    todayDecoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                    ),
                  ),
                  selectedDayPredicate: (day) {
                    return isSameDay(selectedDate, day);
                  },
                  onDaySelected: (_, focusedDay) {
                    setState(() {
                      selectedDate = focusedDay;
                    });
                  },
                ),
                Divider(height: 1),

                /// 선택한 날짜의 일기 목록
                Expanded(
                  child: diaryList.isEmpty
                      ? Center(
                          child: Text(
                            "코디를 작성해주세요.",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                            ),
                          ),
                        )
                      : ListView.separated(
                          itemCount: diaryList.length,
                          itemBuilder: (context, index) {
                            // 역순으로 보여주기
                            int i = diaryList.length - index - 1;
                            Record record = diaryList[i];
                            return ListTile(
                              /// text
                              title: Text(
                                record.text,
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.black,
                                ),
                              ),

                              /// createdAt
                              trailing: Text(
                                DateFormat('kk:mm').format(record.createdAt),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),

                              /// 클릭하여 update
                              onTap: () {
                                showUpdateDialog(recordService, record);
                              },

                              /// 꾹 누르면 delete
                              onLongPress: () {
                                showDeleteDialog(recordService, record);
                              },
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            // item 사이에 Divider 추가
                            return Divider(height: 1);
                          },
                        ),
                ),
              ],
            ),
          ),

          /// Floating Action Button
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.create),
            onPressed: () {
              showCreateDialog(recordService);
            },
          ),
        );
      },
    );
  }

  /// 작성하기
  /// 엔터를 누르거나 작성 버튼을 누르는 경우 호출
  void createDiary(RecordService recordService) {
    // 앞뒤 공백 삭제
    String newText = createTextController.text.trim();
    if (newText.isNotEmpty) {
      recordService.create(newText, selectedDate);
      createTextController.text = "";
    }
  }

  /// 수정하기
  /// 엔터를 누르거나 수정 버튼을 누르는 경우 호출
  void updateDiary(RecordService recordService, Record record) {
    // 앞뒤 공백 삭제
    String updatedText = updateTextController.text.trim();
    if (updatedText.isNotEmpty) {
      recordService.update(
        record.createdAt,
        updatedText,
      );
    }
  }

  /// 작성 다이얼로그 보여주기
  void showCreateDialog(RecordService recordService) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("작성"),
          content: TextField(
            controller: createTextController,
            autofocus: true,
            // 커서 색상
            //cursorColor: Colors.indigo,
            decoration: InputDecoration(
              hintText: "코디를 작성해주세요.",
              // 포커스 되었을 때 밑줄 색상
              focusedBorder: UnderlineInputBorder(
                  //borderSide: BorderSide(color: Colors.indigo),
                  ),
            ),
            onSubmitted: (_) {
              // 엔터 누를 때 작성하기
              createDiary(recordService);
              Navigator.pop(context);
            },
          ),
          actions: [
            /// 취소 버튼
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "취소",
                //style: TextStyle(color: Colors.indigo),
              ),
            ),

            /// 작성 버튼
            TextButton(
              onPressed: () {
                createDiary(recordService);
                Navigator.pop(context);
              },
              child: Text(
                "작성",
                //style: TextStyle(color: Colors.indigo),
              ),
            ),
          ],
        );
      },
    );
  }

  /// 수정 다이얼로그 보여주기
  void showUpdateDialog(RecordService recordService, Record record) {
    showDialog(
      context: context,
      builder: (context) {
        updateTextController.text = record.text;
        return AlertDialog(
          title: Text("수정"),
          content: TextField(
            autofocus: true,
            controller: updateTextController,
            // 커서 색상
            //cursorColor: Colors.indigo,
            decoration: InputDecoration(
              hintText: "코디를 작성해주세요.",
              // 포커스 되었을 때 밑줄 색상
              focusedBorder: UnderlineInputBorder(
                  //borderSide: BorderSide(color: Colors.indigo),
                  ),
            ),
            onSubmitted: (v) {
              // 엔터 누를 때 수정하기
              updateDiary(recordService, record);
              Navigator.pop(context);
            },
          ),
          actions: [
            /// 취소 버튼
            TextButton(
              child: Text(
                "취소",
                style: TextStyle(
                  fontSize: 18,
                  //color: Colors.indigo,
                ),
              ),
              onPressed: () => Navigator.pop(context),
            ),

            /// 수정 버튼
            TextButton(
              child: Text(
                "수정",
                style: TextStyle(
                  fontSize: 18,
                  //color: Colors.indigo,
                ),
              ),
              onPressed: () {
                // 수정하기
                updateDiary(recordService, record);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  /// 삭제 다이얼로그 보여주기
  void showDeleteDialog(RecordService recordService, Record record) {
    showDialog(
      context: context,
      builder: (context) {
        updateTextController.text = record.text;
        return AlertDialog(
          title: Text("삭제"),
          content: Text('"${record.text}"를 삭제하시겠습니까?'),
          actions: [
            TextButton(
              child: Text(
                "취소",
                style: TextStyle(
                  fontSize: 18,
                  //color: Colors.indigo,
                ),
              ),
              onPressed: () => Navigator.pop(context),
            ),

            /// Delete
            TextButton(
              child: Text(
                "삭제",
                style: TextStyle(
                  fontSize: 18,
                  //color: Colors.indigo,
                ),
              ),
              onPressed: () {
                recordService.delete(record.createdAt);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
