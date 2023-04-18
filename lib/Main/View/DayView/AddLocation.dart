import 'package:flutter/material.dart';

class AddLocation extends StatelessWidget {
  const AddLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
        child: Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }
}
