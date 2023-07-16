import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({
    super.key,
    required this.imgUrl,
  });

  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return Image.network(imgUrl,
      alignment: Alignment.center,
      height: double.infinity,
      width: double.infinity,
      fit: BoxFit.cover,
      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loading) {
        if (loading == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: loading.expectedTotalBytes != null
                ? loading.cumulativeBytesLoaded/loading.expectedTotalBytes! : null,
          ),
        );
      },
      errorBuilder: (_, __, ___) {
        return const Icon(Icons.image, size: 22,);
      }
    );
  }
}