import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class TwoButtonRowWidget extends StatelessWidget {
  const TwoButtonRowWidget({
    required this.btnLeftOnTap,
    required this.btnRightOnTap,
    this.btnLeftText = 'Prev',
    this.btnRightText = 'Next',
    this.centerText = '',
    this.iconLeft = IconlyBold.arrowLeft2,
    this.iconRight = IconlyBold.arrowRight2,
    Key? key}) : super(key: key);

  final Function() btnLeftOnTap, btnRightOnTap;
  final String btnLeftText, btnRightText, centerText;
  final IconData iconLeft, iconRight;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
            onPressed: btnLeftOnTap,
            child: Row(
              children: [
                Icon(iconLeft),
                Text(btnLeftText),
              ],
            )
        ),
        Text(centerText,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500
          ),
        ),
        ElevatedButton(
            onPressed: btnRightOnTap,
            child: Row(
              children: [
                Text(btnRightText),
                Icon(iconRight),
              ],
            )
        ),
      ],
    );
  }
}
