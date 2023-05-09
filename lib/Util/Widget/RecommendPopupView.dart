import 'package:flutter/material.dart';
import 'package:weatherfit/Util/Widget/Closet.dart';
import 'package:weatherfit/app_theme.dart';

class RecommendPopupView extends StatelessWidget {
  final Widget child;
  final String temp;

  const RecommendPopupView({required this.child, required this.temp});

  void _showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "🤔 ${temp} 이런 옷 어때요?",
            style: AppTheme().lightTheme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          content: Container(
            height: 350,
            width: 250,
            child: Column(
              children: [
                Clothes(
                    clothes: "assets/vest.png", clothesName: "조끼 패딩 + 기모 바지"),
                Clothes(
                    clothes: "assets/raincoat.png", clothesName: "레인 코트 + 청바지"),
                Clothes(clothes: "assets/hoodie.png", clothesName: "후드티 + 슬랙스"),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                "확인",
                style: AppTheme().lightTheme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showPopup(context),
      child: child,
    );
  }
}
