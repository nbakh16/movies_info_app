import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app/routes/app_pages.dart';
import 'app/utils/colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    GetMaterialApp(
      title: "Movies Details",
      theme: ThemeData(
        primarySwatch: mainColor,
        scaffoldBackgroundColor: mainColor.shade800,
        iconTheme: const IconThemeData(color: Colors.yellowAccent),
        progressIndicatorTheme: const ProgressIndicatorThemeData(color: Colors.white),
        textTheme: GoogleFonts.urbanistTextTheme(
          const TextTheme(
            titleLarge: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w800
            ),
            titleMedium: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500
            ),
            labelMedium: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w800
            ),
            bodyLarge: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500
            ),
            bodyMedium: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500
            ),
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.white, fontSize: 18),
          hintStyle: TextStyle(color: Colors.white70),
          counterStyle: TextStyle(color: Colors.white),
          outlineBorder: BorderSide(color: Colors.white),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: mainColor),
              borderRadius: BorderRadius.all(Radius.circular(18))
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(18))
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
