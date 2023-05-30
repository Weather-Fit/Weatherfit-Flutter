import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../Calendar/Model/CalendarModel.dart';

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
  RecordService._privateConstructor();
  static final RecordService _instance = RecordService._privateConstructor();

  static RecordService get instance {
    return _instance;
  }

  User? user;
  List<Record> recordList = [];
  DateTime selectedDay = DateTime.now();
  List<Record> getByDate(DateTime date) {
    return recordList
        .where((record) => isSameDay(date, record.createdAt))
        .toList();
  }

  final recordCollection = FirebaseFirestore.instance.collection('calendar');

  Future<QuerySnapshot> read(String uid) async {
    return recordCollection
        .where('uid', isEqualTo: uid)
        .where('creatAt',
            isGreaterThanOrEqualTo: DateTime(
                selectedDay.year, selectedDay.month, selectedDay.day, 0, 0, 0),
            isLessThanOrEqualTo: DateTime(selectedDay.year, selectedDay.month,
                selectedDay.day, 23, 59, 59))
        .get();
  }

  void create(String text, String image, DateTime? selectedDate,
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
    if (user == null) {
      print("user is null");
    } else {
      await recordCollection.add({
        'uid': user!.uid,
        'text': text,
        'image': image,
        'selectedDate': selectedDate,
        'creatAt': createdAt,
        'selectTemperature': selectTemperature
      });
    }
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
