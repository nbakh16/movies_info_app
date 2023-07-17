import 'package:flutter/material.dart';

import '../utils/colors.dart';
import 'custom_network_image.dart';

class CustomCard extends StatelessWidget {

  final String image, title, subTitle;
  final IconData? subIcon;

  const CustomCard({
    required this.image,
    this.title = '',
    this.subTitle = '',
    this.subIcon,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    double borderRadius = 6.0;

    return Card(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: mainColor.shade400,
          width: 1
        ),
        borderRadius: BorderRadius.circular(borderRadius)
      ),
      elevation: 4,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                mainColor.shade700,
                mainColor.shade700,
                mainColor,
                mainColor.shade400,
              ]
          ),
          borderRadius: BorderRadius.circular(borderRadius)
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                flex: 7,
                child: CustomNetworkImage(
                    imgUrl: image
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(title,
                        style: TextStyle(
                          fontSize: screenWidth<400 ? 14 : screenWidth<700 ? 16 : 20,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(subIcon, size: 14,),
                          Text(subTitle),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}