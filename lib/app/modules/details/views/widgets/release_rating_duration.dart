import 'package:flutter/material.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/number_formatter.dart';

class ReleaseRatingDuration extends StatelessWidget {
  const ReleaseRatingDuration(
      {super.key,
      required this.releaseDate,
      required this.voteCount,
      required this.voteAvg,
      required this.duration});

  final String releaseDate;
  final int voteCount;
  final double voteAvg;
  final int duration;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(NumberFormatter().formatDate(releaseDate),
              style: Theme.of(context).textTheme.titleSmall,),
            Row(
              children: [
                const Icon(Icons.star, size: 26,),
                Column(
                  children: [
                    Text('$voteAvg/10',
                      style: Theme.of(context).textTheme.titleSmall),
                    Text(voteCount.toString(),
                      style: Theme.of(context).textTheme.titleSmall)
                  ],
                )
              ],
            )
          ],
        ),
        duration == 0 ? const SizedBox() :
        Chip(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          backgroundColor: mainColor.shade700,
          label: Text(NumberFormatter().formatDuration(duration),
            style: TextStyle(
                color: mainColor.shade200,
                fontWeight: FontWeight.w400
            ),
          ),
        )
      ],
    );
  }
}
