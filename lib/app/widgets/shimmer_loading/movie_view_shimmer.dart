import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:movies_details/app/utils/colors.dart';

class MovieViewShimmerLoading extends StatelessWidget {
  const MovieViewShimmerLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;

    return GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: screenWidth<700 ? 2 : screenWidth<900 ? 3 : 4,
            childAspectRatio: 0.65
        ),
        itemCount: 12,
        itemBuilder: (context, index) {
          return Animate(
            effects: [ShimmerEffect(delay: 500.ms, color: mainColor.shade300.withOpacity(0.5))],
            onPlay: (controller) => controller.repeat(),
            child: Container(
              margin: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                  color: mainColor.shade600,
                  borderRadius: BorderRadius.circular(6.0)
              ),
            ),
          );
        }
    );
  }
}