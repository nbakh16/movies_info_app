import 'package:flutter/material.dart';

import '../utils/colors.dart';

class CircularIconButton extends StatelessWidget {
  const CircularIconButton({
    super.key,
    this.onTap,
    this.icon = const Icon(Icons.add)
  });

  final void Function()? onTap;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
            color: mainColor.withOpacity(0.45),
            borderRadius: BorderRadius.circular(33),
            border: Border.all(width: 1.25, color: Colors.yellowAccent)
        ),
        child: IconButton(
            onPressed: onTap,
            icon: icon
        )
    );
  }
}