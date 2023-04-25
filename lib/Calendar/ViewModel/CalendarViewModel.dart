import 'package:flutter/cupertino.dart';

import '../../Util/calendar_service.dart';

DateTime selectedDate = DateTime.now();

TextEditingController createTextController = TextEditingController();

TextEditingController updateTextController = TextEditingController();

void creatRecord(RecordService recordService) {
  String newText = createTextController.text.trim();
  if (newText.isNotEmpty) {
    recordService.create(newText, selectedDate);
    createTextController.text = "";
  }
}

void updateRecord(RecordService recordService, Record record) {
  String updatedText = updateTextController.text.trim();
  if (updatedText.isNotEmpty) {
    recordService.update(
      record.createdAt,
      updatedText,
    );
  }
}
