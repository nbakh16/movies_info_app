import 'package:flutter/material.dart';

import '../utils/colors.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: mainColor,
      width: 225,
    );
  }
}