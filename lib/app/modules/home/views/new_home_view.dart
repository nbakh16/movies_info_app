import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:movies_details/app/modules/home/views/widets/movie_slider.dart';
import 'package:movies_details/app/modules/home/views/widets/movies_by_category.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/custom_drawer.dart';
import '../../details/controllers/details_controller.dart';
import '../controllers/home_controller.dart';

class NewHomeView extends GetView<HomeController> {
  NewHomeView({Key? key}) : super(key: key);

  final HomeController homeController = Get.find();
  final DetailsController detailsController = Get.put(DetailsController());
  // final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: 'Movie App'),
        drawer: const SafeArea(
          child: CustomDrawer(),
        ),
        body: Center(
          child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MovieSlider(),
                    CustomScrollView(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      slivers: [
                        MoviesByCategory(
                          categoryTitle: 'Popular',
                          list: homeController.popularMoviesList
                        ),
                        MoviesByCategory(
                            categoryTitle: 'Upcoming',
                            list: homeController.upcomingMoviesList
                        ),
                        MoviesByCategory(
                            categoryTitle: 'Top Rated (G.0.A.T)',
                            list: homeController.topRatedMoviesList
                        ),
                      ],
                    )
                  ],
                )
              )
          ),
        )
    );
  }
}

