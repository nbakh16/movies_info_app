import 'package:flutter/material.dart';

import '../utils/colors.dart';
import 'custom_network_image.dart';

class MovieSliderCard extends StatelessWidget {
  final String image, title, subTitle;
  final IconData? subIcon;
  final VoidCallback? onTap;

  const MovieSliderCard({
    required this.image,
    this.title = '',
    this.subTitle = '',
    this.subIcon,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double borderRadius = 6.0;

    return InkWell(
      onTap: onTap,
      child: Card(
          clipBehavior: Clip.hardEdge,
          shape: RoundedRectangleBorder(
              side: BorderSide(color: mainColor.shade400, width: 0.75),
              borderRadius: BorderRadius.circular(borderRadius)),
          elevation: 6,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              CustomNetworkImage(imgUrl: image),
              Container(
                color: mainColor.withOpacity(0.45),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          title,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontSize: 18),
                          maxLines: 2,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            subIcon,
                            size: 14,
                          ),
                          Text(subTitle),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
