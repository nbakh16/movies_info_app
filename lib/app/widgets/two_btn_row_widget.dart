import 'package:flutter/material.dart';

class TwoButtonRowWidget extends StatelessWidget {
  const TwoButtonRowWidget({
    required this.btnLeftOnTap,
    required this.btnRightOnTap,
    this.btnLeftText = 'Prev',
    this.btnRightText = 'Next',
    this.centerText = '',
    Key? key}) : super(key: key);

  final Function() btnLeftOnTap, btnRightOnTap;
  final String btnLeftText, btnRightText, centerText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
            onPressed: btnLeftOnTap,
            child: Text(btnLeftText)
        ),
        Text(centerText),
        ElevatedButton(
            onPressed: btnRightOnTap,
            child: Text(btnRightText)
        ),
      ],
    );
  }
}
