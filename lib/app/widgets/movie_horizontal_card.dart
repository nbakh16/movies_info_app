import 'package:flutter/material.dart';

import '../utils/colors.dart';
import 'custom_network_image.dart';


class MovieHorizontalCard extends StatelessWidget {
  const MovieHorizontalCard({
    super.key,
    required this.image,
    required this.title,
    required this.subTitleTop,
    required this.subTitleBottom,
    this.onTap,
  });

  final String image, title, subTitleTop, subTitleBottom;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: SizedBox(
            height: 185.0,
            width: double.infinity,
            child: Card(
              color: mainColor,
              clipBehavior: Clip.hardEdge,
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.0)
              ),
              child: CustomNetworkImage(imgUrl: image,),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 8.0, right: 8.0,
            top: 4.0, bottom: 0.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                flex: 7,
                child: Text(title,
                  style: Theme.of(context).textTheme.titleLarge,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.star),
                          Text(subTitleTop,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                      const Text('●'),
                      Text(subTitleBottom)
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}