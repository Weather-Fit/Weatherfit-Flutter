import 'package:flutter/material.dart';
import 'package:weatherfit/Util/Widget/Clothes.dart';

class RecordScollView extends StatelessWidget {
  const RecordScollView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: EdgeInsets.all(8),
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
            alignment: Alignment.centerRight,
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 30,
            ),
          ),
          Clothes(clothes: "assets/vest.png", clothesName: "조끼 패딩 + 기모 바지"),
          Clothes(clothes: "assets/raincoat.png", clothesName: "레인 코트 + 청바지"),
          Clothes(clothes: "assets/hoodie.png", clothesName: "후드티 + 슬랙스"),
        ],
      ),
    );
  }
}
