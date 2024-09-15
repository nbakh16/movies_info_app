import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

void imageViewDialog({
  required BuildContext context,
  required ImageProvider<Object>? imageProvider,
}) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: '',
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (context, anim1, anim2) {
      return const SizedBox();
    },
    transitionBuilder: (context, anim1, anim2, child) {
      return ScaleTransition(
        scale: Tween<double>(begin: 0.5, end: 1).animate(anim1),
        child: FadeTransition(
          opacity: Tween<double>(begin: 0.5, end: 1).animate(anim1),
          child: AlertDialog(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            contentPadding: const EdgeInsets.all(0),
            content: SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.5,
              width: MediaQuery.sizeOf(context).width * 0.9,
              child: PhotoView(
                backgroundDecoration:
                    const BoxDecoration(color: Colors.transparent),
                imageProvider: imageProvider,
              ),
            ),
            shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
                borderSide: BorderSide.none),
          ),
        ),
      );
    },
  );
}
