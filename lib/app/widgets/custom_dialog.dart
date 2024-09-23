import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_details/app/utils/colors.dart';
import 'package:movies_details/app/utils/const.dart';
import 'package:movies_details/app/widgets/custom_button.dart';
import 'package:photo_view/photo_view.dart';

void aboutDialog({
  required BuildContext context,
}) {
  _customDialog(
      context: context,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.asset('assets/images/app_logo.jpeg', height: 75),
            ),
            const Text('Movie Pop'),
            Text(
              'Version: ${App().version}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 14),
            Text(
              'All data is from TMDB',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(4),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 1.25, horizontal: 3),
                child: Text(
                  'https://www.themoviedb.org',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontStyle: FontStyle.italic,
                      ),
                ),
              ),
            ),
            const SizedBox(height: 14),
            FittedBox(
              child: Text(
                'This project is intended for learning and demonstration.\nOpen-source project.\nAny contributions are appreciated.',
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 28),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80.0),
              child: CustomButton(
                onTap: Get.back,
                btnText: 'Okay',
              ),
            )
          ],
        ),
      ));
}

void imageViewDialog({
  required BuildContext context,
  required ImageProvider<Object>? imageProvider,
}) {
  _customDialog(
    context: context,
    height: MediaQuery.sizeOf(context).height * 0.5,
    width: MediaQuery.sizeOf(context).width * 0.9,
    backgroundColor: Colors.transparent,
    shadowColor: Colors.transparent,
    child: PhotoView(
      backgroundDecoration: const BoxDecoration(color: Colors.transparent),
      imageProvider: imageProvider,
    ),
  );
}

Future<Object?> _customDialog({
  required BuildContext context,
  required Widget child,
  double? height,
  double? width,
  Color backgroundColor = mainColor,
  Color shadowColor = mainColor,
}) {
  return showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: '',
    transitionDuration: const Duration(milliseconds: 180),
    pageBuilder: (context, anim1, anim2) {
      return const SizedBox();
    },
    transitionBuilder: (_, anim1, anim2, __) {
      return ScaleTransition(
        scale: Tween<double>(begin: 0.5, end: 1).animate(anim1),
        child: FadeTransition(
          opacity: Tween<double>(begin: 0.5, end: 1).animate(anim1),
          child: AlertDialog(
            backgroundColor: backgroundColor,
            shadowColor: shadowColor,
            contentPadding: const EdgeInsets.all(0),
            content: SizedBox(
              height: height,
              width: width,
              child: child,
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
