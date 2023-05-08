import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:firebase_database/firebase_database.dart';

import '../Calendar/Model/CalendarModel.dart';

class Record {
  CalendarModel record;
  DateTime createdAt;

  Record({
    required this.record,
    required this.createdAt,
  });
}

class RecordService extends ChangeNotifier {
  List<Record> recordList = [];

  List<Record> getByDate(DateTime date) {
    return recordList
        .where((record) => isSameDay(date, record.createdAt))
        .toList();
  }

  void create(String text, String image, DateTime selectedDate) {
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
      record: CalendarModel(text: text, image: image),
      createdAt: createdAt,
    );
    recordList.add(record);
    notifyListeners();
  }

  void update(DateTime createdAt, String newContent, String selectImage) {
    Record record =
        recordList.firstWhere((record) => record.createdAt == createdAt);

    record.record = CalendarModel(text: newContent, image: selectImage);
    notifyListeners();
  }

  void delete(DateTime createdAt) {
    recordList.removeWhere((record) => record.createdAt == createdAt);
    notifyListeners();
  }
}
