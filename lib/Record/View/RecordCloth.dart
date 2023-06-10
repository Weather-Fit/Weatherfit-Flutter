import 'package:flutter/material.dart';
import 'package:weatherfit/Record/View/RecordScrollView.dart';
import 'package:weatherfit/app_theme.dart';

class RecordCloth extends StatelessWidget {
  const RecordCloth({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppTheme().lightTheme.colorScheme.secondary,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            RecordScollView(),
          ],
        ),
      ),
    );
  }
}
