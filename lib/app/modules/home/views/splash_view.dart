import 'package:flutter/material.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        height: double.infinity,
        width: double.infinity,
        child: const Center(child: Text('Loadding...')),
      ),
    );
  }
}
