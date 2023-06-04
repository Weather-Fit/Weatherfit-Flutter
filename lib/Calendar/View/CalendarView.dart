import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:weatherfit/Calendar/View/RecordView.dart';
import 'package:weatherfit/app_theme.dart';

import '../../Util/auth_service.dart';
import '../../Util/calendar_service.dart';
import '../ViewModel/CalendarViewModel.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({Key? key}) : super(key: key);

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  CalendarFormat calendarFormat = CalendarFormat.month;
  CalendarViewModel calendarViewModel = CalendarViewModel();

  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authService = context.read<AuthService>();
    final user = authService.currentUser()!;
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
                  eventLoader: (day) {
                    return calendarViewModel.getDataByDate(user.uid, day);
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
                  child: FutureBuilder<QuerySnapshot>(
                      future: recordService.read(
                        user.uid,
                      ),
                      builder: (context, snapshot) {
                        final documents = snapshot.data?.docs ?? [];
                        if (documents.isEmpty) {
                          return Center(child: Text("코디를 작성해주세요."));
                        }
                        return ListView.builder(
                          itemCount: documents.length,
                          itemBuilder: (context, index) {
                            final doc = documents[index];
                            String text = doc.get('text');
                            String image = doc.get('image');
                            return ListTile(
                              leading: Image.asset(image),
                              title: Text(
                                text,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w100,
                                  color: AppTheme()
                                      .lightTheme
                                      .colorScheme
                                      .onSurfaceVariant,
                                ),
                              ),
                              trailing: IconButton(
                                icon: Icon(CupertinoIcons.delete),
                                onPressed: () {
                                  recordService.delete(doc.id);
                                },
                              ),
                              onTap: () {
                                recordService.update(doc.id, text, image);
                              },
                            );
                          },
                        );
                      }),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppTheme().lightTheme.colorScheme.primary,
            child: Icon(Icons.create),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RecordView()),
              );
            },
          ),
        );
      },
    );
  }
}
