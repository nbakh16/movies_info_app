import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/colors.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Drawer(
      backgroundColor: mainColor,
      width: 225,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.asset('assets/images/app_logo.jpeg', height: 125)),
          ),
          _drawerTile(textTheme: textTheme, title: 'Movies'),
          _drawerTile(
              textTheme: textTheme, title: 'Series', isComingSoon: true),
          _drawerTile(textTheme: textTheme, title: 'Anime', isComingSoon: true),
          const Spacer(),
          Text('v0.6.0', style: textTheme.bodySmall),
          const SizedBox(height: 6),
        ],
      ),
    );
  }

  Padding _drawerTile({
    required TextTheme textTheme,
    required String title,
    bool isComingSoon = false,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
      child: InkWell(
        onTap: isComingSoon ? null : Get.back,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.symmetric(
              horizontal: BorderSide(color: mainColor.shade400),
            ),
          ),
          padding: const EdgeInsets.fromLTRB(12, 12, 0, 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: textTheme.bodyLarge?.copyWith(
                    color: isComingSoon ? Colors.grey : Colors.white),
              ),
              if (isComingSoon)
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Transform.rotate(
                      angle: 345,
                      child: Image.asset('assets/images/coming_soon.png',
                          width: 45)),
                )
            ],
          ),
        ),
      ),
    );
  }
}
