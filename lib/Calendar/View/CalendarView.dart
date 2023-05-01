import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:weatherfit/app_theme.dart';

import '../../Util/calendar_service.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({Key? key}) : super(key: key);

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  CalendarFormat calendarFormat = CalendarFormat.month;

  DateTime selectedDate = DateTime.now();

  TextEditingController createTextController = TextEditingController();

  TextEditingController updateTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<RecordService>(
      builder: (context, recordService, child) {
        List<Record> recordList = recordService.getByDate(selectedDate);
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
                      todayTextStyle: TextStyle(color: Colors.black),
                      todayDecoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      selectedDecoration: BoxDecoration(
                        color: AppTheme().lightTheme.colorScheme.tertiary,
                        shape: BoxShape.circle,
                      )),
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
                Expanded(
                  child: recordList.isEmpty
                      ? Center(
                          child: Text(
                            "코디를 작성해주세요.",
                            style: TextStyle(
                              color: AppTheme().lightTheme.colorScheme.outline,
                              fontSize: 18,
                            ),
                          ),
                        )
                      : ListView.separated(
                          itemCount: recordList.length,
                          itemBuilder: (context, index) {
                            int i = recordList.length - index - 1;
                            Record record = recordList[i];
                            return ListTile(
                              leading: Icon(Icons.backpack),
                              title: Text(
                                record.text,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: AppTheme()
                                        .lightTheme
                                        .colorScheme
                                        .onSurfaceVariant),
                              ),
                              trailing: Text(
                                DateFormat('kk:mm').format(record.createdAt),
                                style: TextStyle(
                                  fontSize: 10,
                                  color:
                                      AppTheme().lightTheme.colorScheme.outline,
                                ),
                              ),
                              onTap: () {
                                showUpdateDialog(recordService, record);
                              },
                              onLongPress: () {
                                showDeleteDialog(recordService, record);
                              },
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider(height: 1);
                          },
                        ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppTheme().lightTheme.colorScheme.primary,
            child: Icon(Icons.create),
            onPressed: () {
              showCreateDialog(recordService);
            },
          ),
        );
      },
    );
  }

  void creatRecord(RecordService recordService) {
    String newText = createTextController.text.trim();
    String newImage = createTextController.text.trim();
    if (newText.isNotEmpty || newImage.isNotEmpty) {
      recordService.create(newText, selectedDate);
      createTextController.text = "";
    }
  }

  void updateRecord(RecordService recordService, Record record) {
    String updatedText = updateTextController.text.trim();
    if (updatedText.isNotEmpty) {
      recordService.update(record.createdAt, updatedText);
    }
  }

  void showCreateDialog(RecordService recordService) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("작성"),
          content: TextField(
            controller: createTextController,
            autofocus: true,
            decoration: InputDecoration(
              hintText: "코디를 작성해주세요.",
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: AppTheme().lightTheme.colorScheme.primary),
              ),
            ),
            onSubmitted: (_) {
              creatRecord(recordService);
              Navigator.pop(context);
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "취소",
                style:
                    TextStyle(color: AppTheme().lightTheme.colorScheme.primary),
              ),
            ),
            TextButton(
              onPressed: () {
                creatRecord(recordService);
                Navigator.pop(context);
              },
              child: Text(
                "작성",
                style:
                    TextStyle(color: AppTheme().lightTheme.colorScheme.primary),
              ),
            ),
          ],
        );
      },
    );
  }

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
            cursorColor: AppTheme().lightTheme.colorScheme.primary,
            decoration: InputDecoration(
              hintText: "코디를 작성해주세요.",
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: AppTheme().lightTheme.colorScheme.primary),
              ),
            ),
            onSubmitted: (v) {
              updateRecord(recordService, record);
              Navigator.pop(context);
            },
          ),
          actions: [
            TextButton(
              child: Text(
                "취소",
                style: TextStyle(
                  fontSize: 18,
                  color: AppTheme().lightTheme.colorScheme.primary,
                ),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text(
                "수정",
                style: TextStyle(
                  fontSize: 18,
                  color: AppTheme().lightTheme.colorScheme.primary,
                ),
              ),
              onPressed: () {
                updateRecord(recordService, record);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

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
                  color: AppTheme().lightTheme.colorScheme.primary,
                ),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text(
                "삭제",
                style: TextStyle(
                  fontSize: 18,
                  color: AppTheme().lightTheme.colorScheme.primary,
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
