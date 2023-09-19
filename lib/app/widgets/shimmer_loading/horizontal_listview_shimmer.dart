import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../utils/colors.dart';

class HorizontalListViewShimmerLoading extends StatelessWidget {
  const HorizontalListViewShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    double screenHeight = MediaQuery.sizeOf(context).height;

    return Padding(
      padding: const EdgeInsets.only(bottom: 22.0),
      child: SizedBox(
        height: screenWidth<400 ? screenHeight*0.2 : screenWidth<700 ? screenHeight*0.25 : screenHeight*0.55,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
              Expanded(
                flex: 1,
                child: Animate(
                  effects: [ShimmerEffect(delay: 500.ms, color: mainColor.shade300.withOpacity(0.5))],
                  onPlay: (controller) => controller.repeat(),
                  child: Container(
                    height: 25.0,
                    width: double.infinity,
                    margin: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      color: mainColor.shade600,
                      borderRadius: BorderRadius.circular(6.0)
                    ),
                  ),
                ),
              ),
            Expanded(
              flex: 5,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 6,
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Animate(
                    effects: [ShimmerEffect(delay: 500.ms, color: mainColor.shade300.withOpacity(0.5))],
                    onPlay: (controller) => controller.repeat(),
                    child: Container(
                      height: screenWidth<400 ? screenHeight*0.2 : screenWidth<700 ? screenHeight*0.3 : screenHeight*0.5,
                      width: 160,
                      margin: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                          color: mainColor.shade600,
                          borderRadius: BorderRadius.circular(6.0)
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
