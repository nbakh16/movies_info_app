import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/models/movies_model.dart';
import '../../../../routes/app_pages.dart';
import '../../../../utils/colors.dart';
import '../../../../widgets/custom_card.dart';
import '../../controllers/home_controller.dart';


class MovieSlider extends StatelessWidget {
  MovieSlider({super.key});
  final HomeController homeController = Get.find();
  final ValueNotifier<int> _selectedSlider = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Obx(()=>Visibility(
      visible: homeController.moviesList.isNotEmpty,
      replacement: const CircularProgressIndicator(),
      child: Column(
        children: [
          CarouselSlider.builder(
            options: CarouselOptions(
                height: 200.0,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                aspectRatio: 5,
                viewportFraction: 0.9,
                onPageChanged: (int page, _) {
                  _selectedSlider.value = page;
                }
            ),
            itemCount: homeController.moviesList.length,
            itemBuilder: (context, index, pageIndex) {
              Result movie = homeController.moviesList[index];
              return InkWell(
                  onTap: () {
                    Get.toNamed(Routes.DETAILS,
                      arguments: movie,
                    );
                  },
                  child: CustomCard(
                    image: '${homeController.baseImageUrl}${movie.posterPath}',
                    title: movie.title.toString(),
                    subTitle: movie.voteAverage.toString(),
                    subIcon: Icons.star,
                  )
              );
            },
          ),
          const SizedBox(height: 4.0,),
          ValueListenableBuilder(
            valueListenable: _selectedSlider,
            builder: (context, value, _) {
              List<Widget> list = [];
              for (int i = 0; i < homeController.moviesList.length; i++) {
                list.add(
                    AnimatedContainer(
                      width: value == i ? 16 : 8,
                      height: 8,
                      margin: const EdgeInsets.symmetric(horizontal: 2.5),
                      decoration: BoxDecoration(
                          border: Border.all(color: mainColor.shade300),
                          borderRadius: BorderRadius.circular(10),
                          color: value == i ? Colors.yellowAccent : null
                      ),
                      duration: const Duration(milliseconds: 900),
                      curve: Curves.fastOutSlowIn,
                    )
                );
              }
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: list,
              );
            },
          )
        ],
      ),
    ));
  }
}