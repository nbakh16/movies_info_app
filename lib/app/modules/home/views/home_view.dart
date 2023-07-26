import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:movies_details/app/data/models/genre_model.dart';
import 'package:movies_details/app/modules/details/views/details_view.dart';
import 'package:movies_details/app/modules/movie_search/views/movie_search_view.dart';
import 'package:movies_details/app/services/api_service.dart';
import 'package:movies_details/app/widgets/two_btn_row_widget.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/custom_drawer.dart';
import '../../details/controllers/details_controller.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  final HomeController homeController = Get.put(HomeController());
  final DetailsController detailsController = Get.put(DetailsController());
  final ApiService apiService = ApiService();

  RxInt counter = 1.obs;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Trending Movies'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            Get.to(()=>MovieSearchView());
          }, icon: const Icon(Icons.search))
        ],
      ),
      drawer: const SafeArea(
        child: CustomDrawer(),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(()=>
                Visibility(
                  visible: homeController.moviesList.isNotEmpty,
                  replacement: const CircularProgressIndicator(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      pageChangeButtons(),
                      moviesListGridView(screenWidth),
                      pageChangeButtons(),
                    ],
                  ),
                )
            ),
          )
        ),
      )
    );
  }

  GridView moviesListGridView(double screenWidth) {
    return GridView.builder(
            physics: const ScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: screenWidth<700 ? 2 : screenWidth<900 ? 3 : 4,
              childAspectRatio: 0.65
            ),
            itemCount: homeController.moviesList.length,
            itemBuilder: (context, index) {
              return InkWell(
                  onTap: () {
                    apiService.getMovieCasts(homeController.moviesList[index].id!);
                    apiService.getMovieCrews(homeController.moviesList[index].id!);
                    apiService.getSimilarMovies(homeController.moviesList[index].id!);

                    Get.to(()=> DetailsView(
                      movieName: homeController.moviesList[index].originalTitle,
                      overview: homeController.moviesList[index].overview,
                      backdropImagePath: homeController.moviesList[index].backdropPath,
                      releaseDate: homeController.moviesList[index].releaseDate,
                      voteAvg: homeController.moviesList[index].voteAverage,
                      voteCount: homeController.moviesList[index].voteCount,
                      movieGenre: getGenreListOfMovie(index),
                      castList: apiService.movieCastsList,
                      crewList: apiService.movieCrewsList,
                      similarMoviesList: apiService.similarMoviesList,
                    ),
                        transition: Transition.downToUp
                    );
                  },
                  child: CustomCard(
                    image: '${homeController.baseImageUrl}${homeController.moviesList[index].posterPath}',
                    title: homeController.moviesList[index].originalTitle.toString(),
                    subTitle: homeController.moviesList[index].voteAverage.toString(),
                    subIcon: Icons.star,
                  )
              );
            },
          );
  }

  Obx pageChangeButtons() {
    return Obx(()=>
            TwoButtonRowWidget(
              btnLeftOnTap: (){
                if(counter > 1) {
                  counter -= homeController.pageNumber;
                  homeController.getMovies(counter.value);
                }
                else {
                  Get.snackbar(
                    'Page: 1',
                    'Already on First Page!',
                    icon: const Icon(Icons.info_outline),
                    snackPosition: SnackPosition.BOTTOM,
                    colorText: Colors.white,
                    backgroundColor: Colors.redAccent.withOpacity(0.33)
                  );
                }
              },
              btnRightOnTap: (){
                counter += homeController.pageNumber;
                homeController.getMovies(counter.value);
              },
              centerText: 'Page: ${counter.value}',
            ),
          );
  }

  List<GenreElement> getGenreListOfMovie(int index) {
    List<int> genreIdList = homeController.moviesList[index].genreIds!;

    var genreListOfMovie = detailsController.genreList
        .where((genre) => genreIdList
        .contains(genre.id))
        .toList();

    return genreListOfMovie;
  }
}