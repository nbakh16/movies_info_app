import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_details/app/utils/colors.dart';
import 'package:movies_details/app/utils/const.dart';
import 'package:movies_details/app/utils/launch_url.dart';
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
              onTap: () {
                launchThisUrl('https://www.themoviedb.org');
              },
              borderRadius: BorderRadius.circular(4),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 1.5, horizontal: 6),
                child: Text(
                  'themoviedb.org',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        decoration: TextDecoration.underline,
                        fontStyle: FontStyle.italic,
                      ),
                ),
              ),
            ),
            const SizedBox(height: 28),
            FittedBox(
              child: Text(
                'This project is intended for learning and demonstration.\nOpen-source project.\nAny contributions are appreciated.',
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 28),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _iconBtn(
                  context: context,
                  onTap: () {
                    launchThisUrl(
                        'https://play.google.com/store/apps/dev?id=8454097256620416364');
                  },
                  text: 'More Apps',
                  img: 'assets/images/playstore-logo.png',
                ),
                const SizedBox(width: 32),
                _iconBtn(
                  context: context,
                  onTap: () {
                    launchThisUrl('https://github.com/nbakh16/movies_info_app');
                  },
                  text: 'Contribute',
                  img: 'assets/images/github-logo.png',
                ),
              ],
            ),
            const SizedBox(height: 28),
            InkWell(
              onTap: () {
                launchThisUrl(
                    'https://play.google.com/store/apps/details?id=com.nbakh.movie_pop');
              },
              borderRadius: BorderRadius.circular(4),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 0.75,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 12),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 24),
                      Text(
                        '   Rate the app!',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
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

InkWell _iconBtn({
  required BuildContext context,
  required VoidCallback onTap,
  required String text,
  required String img,
}) {
  return InkWell(
    borderRadius: BorderRadius.circular(6),
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.all(2.5),
      child: Column(
        children: [
          Image.asset(img, height: 48),
          const SizedBox(height: 4),
          Text(text, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    ),
  );
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
