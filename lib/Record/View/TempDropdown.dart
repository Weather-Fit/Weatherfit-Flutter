import 'package:flutter/material.dart';
import 'package:weatherfit/app_theme.dart';

class TempDropdown extends StatelessWidget {
  final String selectedTemp;
  final List<String> temps;
  final ValueChanged<String?> onSelected;

  TempDropdown({
    required this.selectedTemp,
    required this.temps,
    required this.onSelected,
  });

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
            value: selectedTemp,
            icon: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
              child: const Icon(Icons.arrow_downward),
            ),
            iconSize: 18,
            elevation: 8,
            style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
            onChanged: onSelected,
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
