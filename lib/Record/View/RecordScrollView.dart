import 'package:flutter/material.dart';
import 'package:weatherfit/Util/Widget/Clothes.dart';

class RecordScollView extends StatelessWidget {
  const RecordScollView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
        children: [
          Clothes(clothes: "assets/vest.png", clothesName: "조끼 패딩 + 기모 바지"),
          Clothes(clothes: "assets/raincoat.png", clothesName: "레인 코트 + 청바지"),
          Clothes(clothes: "assets/hoodie.png", clothesName: "후드티 + 슬랙스"),
          Clothes(clothes: "assets/vest.png", clothesName: "조끼 패딩 + 기모 바지"),
          Clothes(clothes: "assets/raincoat.png", clothesName: "레인 코트 + 청바지"),
          Clothes(clothes: "assets/hoodie.png", clothesName: "후드티 + 슬랙스"),
          Clothes(clothes: "assets/vest.png", clothesName: "조끼 패딩 + 기모 바지"),
          Clothes(clothes: "assets/raincoat.png", clothesName: "레인 코트 + 청바지"),
          Clothes(clothes: "assets/hoodie.png", clothesName: "후드티 + 슬랙스"),
        ],
      ),
    );
  }
}