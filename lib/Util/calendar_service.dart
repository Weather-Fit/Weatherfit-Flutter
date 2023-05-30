import 'dart:convert';
//import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../Calendar/Model/CalendarModel.dart';
import 'auth_service.dart';

class Record {
  String uid;
  CalendarModel record;
  DateTime createdAt;
  DateTime selectedDate;

  Record(
      {required this.uid,
      required this.record,
      required this.createdAt,
      required this.selectedDate});
}

class RecordService extends ChangeNotifier {
  List<Record> recordList = [];

  List<Record> getByDate(DateTime date) {
    return recordList
        .where((record) => isSameDay(date, record.createdAt))
        .toList();
  }

  // Future<List<Record>> getByDate(DateTime selectedDate) async {
  //   DateTime startDateTime =
  //       DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
  //   DateTime endDateTime =
  //       DateTime(selectedDate.year, selectedDate.month, selectedDate.day + 1);

  //   QuerySnapshot snapshot = await FirebaseFirestore.instance
  //       .collection('calendar')
  //       .where('createdAt', isGreaterThanOrEqualTo: startDateTime)
  //       .where('createdAt', isLessThan: endDateTime)
  //       .get();

  //   List<Record> records = snapshot.docs.map((doc) {
  //     DateTime timestamp = doc['createdAt'].toDate();
  //     CalendarModel calendarModel = CalendarModel();
  //     calendarModel.text = doc['text'];
  //     calendarModel.image = doc['image'];
  //     return Record(
  //       uid: doc.id,
  //       record: calendarModel,
  //       createdAt: timestamp,
  //       selectedDate: selectedDate,
  //     );
  //   }).toList();

  //   return records;
  // }

  final recordCollection = FirebaseFirestore.instance.collection('calendar');

  Future<QuerySnapshot> read(String uid) async {
    print("log");
    return recordCollection
        .where('uid', isEqualTo: uid)
        .where('creatAt',
            isGreaterThanOrEqualTo: DateTime(2023, 5, 23, 0, 0, 0),
            isLessThanOrEqualTo: DateTime(2023, 5, 23, 23, 59, 59))
        .get();
  }

  void create(String text, String image, String uid, DateTime? selectedDate,
      DateTime? currentTime, int? selectTemperature) async {
    currentTime = DateTime.now();

    DateTime? createdAt = DateTime(
      selectedDate!.year,
      selectedDate.month,
      selectedDate.day,
      currentTime.hour,
      currentTime.minute,
      currentTime.second,
    );

    await recordCollection.add({
      'uid': uid,
      'text': text,
      'image': image,
      'selectedDate': selectedDate,
      'creatAt': createdAt,
      'selectTemperature': selectTemperature
    });
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
}
