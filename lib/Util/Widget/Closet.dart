import 'package:flutter/material.dart';
import 'package:weatherfit/app_theme.dart';

class Clothes extends StatelessWidget {
  final String clothes;
  final String clothesName;

  Clothes({required this.clothes, required this.clothesName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 8,
              color: Colors.black12,
              spreadRadius: 4,
            ),
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 40,
              height: 40,
              child: Image.asset(clothes),
            ),
            Text(
              clothesName,
              style: AppTheme().lightTheme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
