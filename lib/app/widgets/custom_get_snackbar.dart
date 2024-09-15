import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCustomSnackbar({
  String title = 'Failed',
  required String message,
  Color bgColor = Colors.redAccent,
  IconData icon = Icons.info_outline,
  int durationSecond = 3,
}) {
  Get.snackbar(
    '',
    '',
    titleText: Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    messageText: Text(
      message,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Colors.white,
      ),
    ),
    backgroundColor: bgColor,
    snackPosition: SnackPosition.BOTTOM,
    duration: Duration(seconds: durationSecond),
    icon: Icon(icon, color: Colors.white, size: 24),
    margin: const EdgeInsets.all(12),
  );
}
