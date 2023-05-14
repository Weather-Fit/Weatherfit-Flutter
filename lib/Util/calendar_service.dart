import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

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
  final recordCollection = FirebaseFirestore.instance.collection('calendar');

  Future<QuerySnapshot> read(String uid) async {
    return recordCollection.where('uid', isEqualTo: uid).get();
  }

  void create(
      String text, String image, String uid, DateTime selectedDate) async {
    DateTime now = DateTime.now();

    DateTime createdAt = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      now.hour,
      now.minute,
      now.second,
    );

    await recordCollection
        .add({'uid': uid, 'text': text, 'image': image, 'creatAt': createdAt});
    notifyListeners();
  }

  void update(String creatAt, String text, String image) async {
    await recordCollection.doc(creatAt).update({
      'text': text,
      'image': image,
    });
    notifyListeners();
  }

  void delete(String creatAt) async {
    await recordCollection.doc(creatAt).delete();
    notifyListeners();
  }

  List<Record> recordList = [];

  List<Record> getByDate(DateTime date) {
    return recordList
        .where((record) => isSameDay(date, record.createdAt))
        .toList();
  }
}
