import 'package:flutter/material.dart';
import 'package:money_management_app1/utils/styles_color.dart';

// ignore: must_be_immutable
class BalanceShow extends StatelessWidget {
  String mainText;
  String typeText;
  Color color;
  BalanceShow({
    required this.mainText,
    required this.color,
    required this.typeText,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(children: [
        TextSpan(
          text: mainText,
          style: listTileText,
        ),
        TextSpan(
          text: typeText,
          style:  TextStyle(
            fontSize: 25,
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ]),
    );
  }
}
