import 'package:flutter/material.dart';

import '../utils/colors.dart';


class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onTap,
    required this.btnText,
    this.btnElevation = 0,
    this.bgColor = Colors.transparent,
    this.shadowColor = Colors.transparent,
    this.textSize = 14,
  });

  final Function() onTap;
  final String btnText;
  final double btnElevation, textSize;
  final Color bgColor, shadowColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(50),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30)
        ),
        side: BorderSide(
            color: mainColor.shade300,
            width: 2
        ),
        elevation: btnElevation,
        backgroundColor: bgColor,
        shadowColor: shadowColor,
      ),
      child: Text(btnText,
        style: TextStyle(fontSize: textSize, fontWeight: FontWeight.w500),
      ),
    );
  }
}