import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

class Record {
  String text;
  DateTime createdAt;
  String image;

  Record({
    required this.text,
    required this.createdAt,
    required this.image,
  });

  Map<String, dynamic> toJson() {
    return {
      "text": text,
      "createdAt": createdAt.toString(),
      "image": image,
    };
  }

  factory Record.fromJson(Map<String, dynamic> jsonMap) {
    return Record(
      text: jsonMap['text'],
      createdAt: DateTime.parse(jsonMap['createdAt']),
      image: jsonMap['image'],
    );
  }
}

class RecordService extends ChangeNotifier {
  RecordService(this.prefs) {
    List<String> strintRecordList = prefs.getStringList("recordList") ?? [];
    for (String stringRecord in strintRecordList) {
      Map<String, dynamic> jsonMap = jsonDecode(stringRecord);

      Record record = Record.fromJson(jsonMap);
      recordList.add(record);
    }
  }

  SharedPreferences prefs;

  List<Record> recordList = [];

  List<Record> getByDate(DateTime date) {
    return recordList
        .where((record) => isSameDay(date, record.createdAt))
        .toList();
  }

  void create(String text, DateTime selectedDate, String image) {
    DateTime now = DateTime.now();

    DateTime createdAt = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      now.hour,
      now.minute,
      now.second,
    );

    Record record = Record(
      text: text,
      createdAt: createdAt,
      image: image,
    );
    recordList.add(record);
    notifyListeners();

    _saveRecordList();
  }

  void update(DateTime createdAt, String newContent, String newImage) {
    Record record =
        recordList.firstWhere((record) => record.createdAt == createdAt);

    record.text = newContent;
    record.image = newImage;
    notifyListeners();

    _saveRecordList();
  }

  void delete(DateTime createdAt) {
    recordList.removeWhere((record) => record.createdAt == createdAt);
    notifyListeners();

    _saveRecordList();
  }

  void _saveRecordList() {
    List<String> stringRecordList = [];
    for (Record record in recordList) {
      Map<String, dynamic> jsonMap = record.toJson();

      String stringRecord = jsonEncode(jsonMap);
      stringRecordList.add(stringRecord);
    }
    prefs.setStringList("recordList", stringRecordList);
  }
}
