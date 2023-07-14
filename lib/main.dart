import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'app/utils/colors.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: "Movies Details",
      theme: ThemeData(
          primarySwatch: mainColor,
          scaffoldBackgroundColor: mainColor.shade800,
          iconTheme: const IconThemeData(color: Colors.yellowAccent),
          progressIndicatorTheme: const ProgressIndicatorThemeData(color: Colors.white),
          textTheme: const TextTheme(
              bodyMedium: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500
              )
          )
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
