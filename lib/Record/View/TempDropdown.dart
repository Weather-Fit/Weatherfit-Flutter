import 'package:flutter/material.dart';
import 'package:weatherfit/app_theme.dart';

class TempDropdown extends StatefulWidget {
  @override
  _TempDropdownState createState() => _TempDropdownState();
}

class _TempDropdownState extends State<TempDropdown> {
  String dropdownValue = '16~12º';
  List<String> temps = [
    '28º 이상',
    '27~23º',
    '22~20º',
    '19~17º',
    '16~12º',
    '11~9º',
    '8~5º',
    '4º 이하'
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        width: double.infinity,
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: dropdownValue,
            icon: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
              child: const Icon(Icons.arrow_downward),
            ),
            iconSize: 18,
            elevation: 8,
            style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
            onChanged: (value) {
              setState(() {
                dropdownValue = value!;
              });
            },
            items: temps.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                  child: Text(
                    value,
                    style: AppTheme().lightTheme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
