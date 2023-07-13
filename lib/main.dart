import 'package:flutter/material.dart';
import 'package:movies_details/screen/home_screen.dart';
import 'package:movies_details/utils/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
      home: const HomeScreen(),
    );
  }
}
