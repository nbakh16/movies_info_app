import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/const.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 2),
            Lottie.asset('assets/lottie/movie.json',
                width: MediaQuery.sizeOf(context).shortestSide * 0.45),
            const Spacer(),
            Text(
              getGreetingMessage().split(', ').first,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(letterSpacing: 1.75),
            ).animate().fade(duration: 900.ms),
            const SizedBox(height: 4),
            Text(
              getGreetingMessage().split(', ').last,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(letterSpacing: 1.2),
            ).animate().fade(duration: 1600.ms),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
