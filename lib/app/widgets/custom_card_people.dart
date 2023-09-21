import 'package:flutter/material.dart';

import '../utils/colors.dart';
import 'custom_network_image.dart';

class CustomCardPeople extends StatelessWidget {

  final String image, title, subTitle;
  final IconData? subIcon;
  final Function()? onTap;

  const CustomCardPeople({
    required this.image,
    this.title = '',
    this.subTitle = '',
    this.subIcon,
    this.onTap,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    double borderRadius = 6.0;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.00),
        child: Card(
          clipBehavior: Clip.hardEdge,
          shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: mainColor.shade400,
                  width: 1
              ),
              borderRadius: BorderRadius.circular(borderRadius)
          ),
          elevation: 5,
          child: Container(
            height: double.maxFinite,
            width: screenWidth<700 ? screenWidth * 0.35 : screenWidth * 0.25,
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
              padding: const EdgeInsets.all(4.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    flex: 3,
                    child: CustomNetworkImage(
                        imgUrl: image
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(title,
                          style: TextStyle(
                            fontSize: screenWidth<700 ? 14 : 16,
                            fontWeight: FontWeight.w900,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Wrap(
                          direction: Axis.horizontal,
                          alignment: WrapAlignment.center,
                          spacing: 2.5,
                          children: [
                            Icon(subIcon,
                              size: screenWidth<700 ? 14 : 18,
                            ),
                            Text(subTitle,
                              style: TextStyle(
                                fontSize: screenWidth<700 ? 14 : 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.white70
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ),
      ),
    );
  }
}