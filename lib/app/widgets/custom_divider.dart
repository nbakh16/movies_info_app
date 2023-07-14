import 'package:flutter/material.dart';

import '../utils/colors.dart';


class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(height: 22.0, thickness: 1, color: mainColor.shade400,);
  }
}