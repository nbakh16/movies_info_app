import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:movies_details/app/modules/home/views/widets/movie_slider.dart';
import '../../../data/models/movies_model.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/custom_card_people.dart';
import '../../../widgets/custom_drawer.dart';
import '../../../widgets/people_list_widget.dart';
import '../controllers/home_controller.dart';

class NewHomeView extends GetView<HomeController> {
  NewHomeView({Key? key}) : super(key: key);

  final HomeController homeController = Get.find();
  // final DetailsController detailsController = Get.put(DetailsController());
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
                        Obx(()=>
                            Visibility(
                              visible: homeController.upcomingMoviesList.isNotEmpty,
                              replacement: const SliverToBoxAdapter(),
                              child: PeopleListWidget(
                                  category: 'Upcoming Movies',
                                  listView: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: homeController.upcomingMoviesList.length,
                                      itemBuilder: (context, index){
                                        return CustomCardPeople(
                                          onTap: () {
                                            // movie.value = similarMoviesList[index];
                                            // apiService.getMovieCasts(movie.value.id!);
                                            // apiService.getMovieCrews(movie.value.id!);
                                            // apiService.getSimilarMovies(movie.value.id!);
                                          },
                                          image: 'https://image.tmdb.org/t/p/original${homeController.upcomingMoviesList[index].posterPath}',
                                          title: homeController.upcomingMoviesList[index].title.toString().trim(),
                                          subTitle: homeController.upcomingMoviesList[index].voteAverage.toString().trim(),
                                          subIcon: Icons.star,
                                          // subTitle: '(${crewList![index].job})',
                                        );
                                      }
                                  )
                              ),
                            )
                        ),
                        Obx(()=>
                            Visibility(
                              visible: homeController.upcomingMoviesList.isNotEmpty,
                              replacement: const SliverToBoxAdapter(),
                              child: PeopleListWidget(
                                  category: 'Top Movies (G.O.A.T)',
                                  listView: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: homeController.topRatedMoviesList.length,
                                      itemBuilder: (context, index){
                                        Result movie = homeController.topRatedMoviesList[index];

                                        return CustomCardPeople(
                                          onTap: () {
                                            // movie.value = similarMoviesList[index];
                                            // apiService.getMovieCasts(movie.value.id!);
                                            // apiService.getMovieCrews(movie.value.id!);
                                            // apiService.getSimilarMovies(movie.value.id!);
                                          },
                                          image: 'https://image.tmdb.org/t/p/original${movie.posterPath}',
                                          title: movie.title.toString().trim(),
                                          subTitle: movie.voteAverage.toString().trim(),
                                          subIcon: Icons.star,
                                          // subTitle: '(${crewList![index].job})',
                                        );
                                      }
                                  )
                              ),
                            )
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

