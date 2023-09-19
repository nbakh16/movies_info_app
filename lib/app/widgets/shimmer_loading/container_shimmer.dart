import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../utils/colors.dart';

class ContainerShimmerLoading extends StatelessWidget {
  const ContainerShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Animate(
        effects: [ShimmerEffect(delay: 500.ms, color: mainColor.shade300.withOpacity(0.5))],
        onPlay: (controller) => controller.repeat(),
        child: Container(
          height: 200.0,
          width: double.infinity,
          margin: const EdgeInsets.all(4.0),
          decoration: BoxDecoration(
              color: mainColor.shade600,
              borderRadius: BorderRadius.circular(6.0)
          ),
        ),
      ),
    );
  }
}
