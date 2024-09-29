import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:movies_details/app/utils/colors.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({
    super.key,
    required this.imgUrl,
  });

  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
          topRight: Radius.circular(6.0),
          topLeft: Radius.circular(6.0),
        )),
        clipBehavior: Clip.hardEdge,
        child: CachedNetworkImage(
          key: UniqueKey(),
          imageUrl: imgUrl,
          imageBuilder: (context, imageProvider) => Container(
            height: double.infinity,
            width: MediaQuery.sizeOf(context).width < 700
                ? double.infinity
                : MediaQuery.sizeOf(context).width * 0.5,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
          ),
          progressIndicatorBuilder: (context, url, downloadProgress) => Center(
              child:
                  CircularProgressIndicator(value: downloadProgress.progress)),
          errorWidget: (_, __, ___) => Icon(
            Icons.image,
            size: 40,
            color: mainColor.shade300,
          ),
          cacheManager: CacheManager(Config(
            'customCacheKey',
            stalePeriod: const Duration(days: 7),
            maxNrOfCacheObjects: 124,
          )),
        )

        // Image.network(imgUrl,
        //   alignment: Alignment.center,
        //   height: double.infinity,
        //   width: double.infinity,
        //   fit: BoxFit.cover,
        //   loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loading) {
        //     if (loading == null) return child;
        //     return Center(
        //       child: CircularProgressIndicator(
        //         value: loading.expectedTotalBytes != null
        //             ? loading.cumulativeBytesLoaded/loading.expectedTotalBytes! : null,
        //       ),
        //     );
        //   },
        //   errorBuilder: (_, __, ___) {
        //     return Icon(Icons.image, size: 40, color: mainColor.shade300,);
        //   }
        // ),
        );
  }
}
