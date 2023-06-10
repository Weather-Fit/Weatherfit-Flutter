import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:weatherfit/Util/Widget/Clothes.dart';
import 'package:weatherfit/Util/calendar_service.dart';
import 'package:weatherfit/app_theme.dart';

class RecommendPopupView extends StatefulWidget {
  final Widget child;
  final String temp;

  const RecommendPopupView({required this.child, required this.temp});

  @override
  State<RecommendPopupView> createState() => _RecommendPopupViewState();
}

class _RecommendPopupViewState extends State<RecommendPopupView> {
  List<Widget> clothesList = [];

  Future<void> fetchClothes(String temp) async {
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
    var results = temp.split('.');
    int toInt = int.parse(results[0]);
    print(toInt);
    return [toInt, toInt];
  }

  void _showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FutureBuilder(
          future: fetchClothes(widget.temp),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.error != null) {
              return Text('Error: ${snapshot.error}');
            } else {
              return AlertDialog(
                title: Text(
                  "🤔 ${widget.temp} 이런 옷 어때요?",
                  style: AppTheme().lightTheme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                content: Container(
                  height: 350,
                  width: 250,
                  child: Column(
                    children: [
                      if (clothesList.isEmpty)
                        Text('데이터가 없어요 :(', style: TextStyle(fontSize: 24)),
                      ...clothesList,
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    child: Text(
                      "확인",
                      style:
                          AppTheme().lightTheme.textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showPopup(context),
      child: widget.child,
    );
  }
}
