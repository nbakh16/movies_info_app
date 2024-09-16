import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        height: double.infinity,
        width: double.infinity,
        child: Positioned(
          right: 500,
          child: Center(
              child: Lottie.asset('assets/lottie/movie.json',
                  width: MediaQuery.sizeOf(context).width * 0.5)),
        ),
      ),
    );
  }
}
