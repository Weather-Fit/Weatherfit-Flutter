import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:weatherfit/Record/View/TempDropdown.dart';
import 'package:weatherfit/Util/Widget/Clothes.dart';
import 'package:weatherfit/Util/calendar_service.dart';

class RecordScollView extends StatefulWidget {
  RecordScollView({super.key});

  @override
  _RecordScollViewState createState() => _RecordScollViewState();
}

class _RecordScollViewState extends State<RecordScollView> {
  String selectedTemp = '12~16º';
  List<Widget> clothesList = [];

  List<String> temps = [
    '28~40º',
    '23~27º',
    '20~22º',
    '17~19º',
    '12~16º',
    '9~11º',
    '5~8º',
    '-10~4º'
  ];

  @override
  void initState() {
    super.initState();
    fetchClothes(selectedTemp);
  }

  void fetchClothes(String temp) async {
    List<int> tempRange = _parseTempRange(temp);

    QuerySnapshot snapshot = await RecordService.instance
        .getByTemperatureRange(tempRange[0], tempRange[1]);

    List<Widget> fetchedList = snapshot.docs.map((doc) {
      return Clothes(clothes: doc.get('image'), clothesName: doc.get('text'));
    }).toList();

    setState(() {
      clothesList = fetchedList;
      print(clothesList);
    });
  }

  List<int> _parseTempRange(String temp) {
    var results = temp.split('~');
    int first = int.parse(results[0]);
    int second = int.parse(results[1].substring(0, results[1].length - 1));
    return [first, second];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TempDropdown(
          selectedTemp: selectedTemp,
          temps: temps,
          onSelected: (value) {
            if (value != null) {
              setState(() {
                selectedTemp = value;
              });
              fetchClothes(value);
            }
          },
        ),
        if (clothesList.isEmpty)
          Text('데이터가 없어요 😭', style: TextStyle(fontSize: 24)),
        ...clothesList
      ],
    );
  }
}
