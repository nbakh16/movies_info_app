import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
import 'package:movies_details/app/utils/const.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Center(
                child: Lottie.asset('assets/lottie/movie.json',
                    width: MediaQuery.sizeOf(context).width * 0.5)),
            Padding(
              padding: const EdgeInsets.only(bottom: 100.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    getGreetingMessage().split(', ').first,
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(letterSpacing: 1.75),
                  ).animate().fade(duration: 900.ms),
                  const SizedBox(height: 6),
                  Text(
                    getGreetingMessage().split(', ').last,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(letterSpacing: 1.2),
                  ).animate().fade(duration: 1600.ms),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
