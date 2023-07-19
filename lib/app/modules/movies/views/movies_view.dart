import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/models/genre_model.dart';
import '../../../data/models/movies_model.dart';
import '../../../services/api_service.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/custom_drawer.dart';
import '../../../widgets/two_btn_row_widget.dart';
import '../../details/controllers/details_controller.dart';
import '../../movie_search/views/movie_search_view.dart';
import '../controllers/movies_controller.dart';

class MoviesView extends GetView<MoviesController> {
  final RxList<Result>? moviesList;
  final int? genreId;
  final String? genreName;

  MoviesView({
    this.moviesList,
    this.genreId,
    this.genreName,
    Key? key}) : super(key: key);

  final DetailsController detailsController = Get.put(DetailsController());
  final ApiService apiService = ApiService();

  RxInt counter = 1.obs;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
        appBar: AppBar(
          title: Text('$genreName Movies'),
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
                      visible: moviesList!.isNotEmpty,
                      replacement: const CircularProgressIndicator(),
                      child:
                          Column(
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
      itemCount: moviesList!.length,
      itemBuilder: (context, index) {
        return InkWell(
            onTap: () {
              // apiService.getMovieCasts(homeController.moviesList[index].id!);
              // apiService.getMovieCrews(homeController.moviesList[index].id!);
              // apiService.getSimilarMovies(homeController.moviesList[index].id!);
              //
              // Get.to(()=> DetailsView(
              //   movieName: homeController.moviesList[index].originalTitle,
              //   overview: homeController.moviesList[index].overview,
              //   backdropImagePath: homeController.moviesList[index].backdropPath,
              //   releaseDate: homeController.moviesList[index].releaseDate,
              //   voteAvg: homeController.moviesList[index].voteAverage,
              //   voteCount: homeController.moviesList[index].voteCount,
              //   movieGenre: getGenreListOfMovie(index),
              //   castList: apiService.movieCastsList,
              //   crewList: apiService.movieCrewsList,
              //   similarMoviesList: apiService.similarMoviesList,
              // ),
              //     transition: Transition.downToUp
              // );
            },
            child: CustomCard(
              image: '${apiService.baseImageUrl}${moviesList![index].posterPath}',
              title: moviesList![index].originalTitle.toString(),
              subTitle: moviesList![index].voteAverage.toString(),
              subIcon: Icons.star,
            )
        );
      },
    );
  }

  //TODO: Fix page change
  Obx pageChangeButtons() {
    return Obx(()=>
        TwoButtonRowWidget(
          btnLeftOnTap: (){
            if(counter > 1) {
              counter--;
              moviesList!.clear();
              apiService.getMoviesListByGenre(genreId!, counter.value);
              moviesList!.addAll(apiService.moviesListByGenre);
            }
          },
          btnRightOnTap: (){
            counter++;
            moviesList!.clear();
            apiService.getMoviesListByGenre(genreId!, counter.value);
            moviesList!.addAll(apiService.moviesListByGenre);
          },
          centerText: 'Page: ${counter.value}',
        ),
    );
  }

  List<GenreElement> getGenreListOfMovie(int index) {
    List<int> genreIdList = moviesList![index].genreIds!;

    var genreListOfMovie = detailsController.genreList
        .where((genre) => genreIdList
        .contains(genre.id))
        .toList();

    return genreListOfMovie;
  }
}
