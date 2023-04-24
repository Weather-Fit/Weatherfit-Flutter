import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Record {
  String text;
  DateTime createdAt; // 작성 시간

  Record({
    required this.text,
    required this.createdAt,
  });
}

class RecordService extends ChangeNotifier {
  List<Record> recordList = [];

  /// 특정 날짜의 diary 조회
  List<Record> getByDate(DateTime date) {
    return recordList
        .where((record) => isSameDay(date, record.createdAt))
        .toList();
  }

  /// Diary 작성
  void create(String text, DateTime selectedDate) {
    DateTime now = DateTime.now();

    // 선택된 날짜에 현재 시간으로 추가
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
    );
    recordList.add(record);
    notifyListeners();
  }

  void update(DateTime createdAt, String newContent) {
    Record record =
        recordList.firstWhere((record) => record.createdAt == createdAt);
    record.text = newContent;
    notifyListeners();
  }

  void delete(DateTime createdAt) {
    recordList.removeWhere((record) => record.createdAt == createdAt);
    notifyListeners();
  }
}
