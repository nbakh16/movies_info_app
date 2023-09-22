import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_details/app/widgets/movie_slider_card.dart';

import '../../../../data/models/movie/movies_model.dart';
import '../../../../routes/app_pages.dart';
import '../../../../utils/colors.dart';
import '../../../../widgets/shimmer_loading/container_shimmer.dart';
import '../../controllers/home_controller.dart';


class MovieSlider extends StatelessWidget {
  MovieSlider({super.key});
  final HomeController homeController = Get.find();
  final ValueNotifier<int> _selectedSlider = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    final int totalItem = 6;

    return Obx(()=>Visibility(
      visible: homeController.moviesList.isNotEmpty,
      replacement: const ContainerShimmerLoading(),
      child: Column(
        children: [
          CarouselSlider.builder(
            options: CarouselOptions(
                height: 200.0,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                aspectRatio: 5,
                viewportFraction: screenWidth<700 ? 0.9 : screenWidth<900 ? 0.5 : 0.4,
                onPageChanged: (int page, _) {
                  _selectedSlider.value = page;
                }
            ),
            itemCount: totalItem,
            itemBuilder: (context, index, pageIndex) {
              Result movie = homeController.moviesList[index];
              return InkWell(
                  onTap: () {
                    Get.toNamed(Routes.DETAILS,
                      arguments: movie.id,
                    );
                  },
                  child: MovieSliderCard(
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
              for (int i = 0; i < totalItem; i++) {
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