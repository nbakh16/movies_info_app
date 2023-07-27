import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:movies_details/app/modules/home/views/home_view.dart';
import 'package:movies_details/app/widgets/custom_app_bar.dart';

import '../../../data/models/movies_model.dart';
import '../../../services/api_service.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/custom_drawer.dart';
import '../../../widgets/two_btn_row_widget.dart';
import '../../details/views/details_view.dart';
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

  final ApiService apiService = ApiService();

  RxInt counter = 1.obs;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
        appBar: CustomAppBar(title: '$genreName Movies'),
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
              apiService.getMovieCasts(moviesList![index].id!);
              apiService.getMovieCrews(moviesList![index].id!);
              apiService.getSimilarMovies(moviesList![index].id!);

              Get.to(()=> DetailsView(
                movieName: moviesList![index].originalTitle,
                overview: moviesList![index].overview,
                backdropImagePath: moviesList![index].backdropPath,
                releaseDate: moviesList![index].releaseDate,
                voteAvg: moviesList![index].voteAverage,
                voteCount: moviesList![index].voteCount,
                movieGenre: HomeView().getGenreListOfMovie(moviesList![index].genreIds!),
                castList: apiService.movieCastsList,
                crewList: apiService.movieCrewsList,
                similarMoviesList: apiService.similarMoviesList,
              ),
                  transition: Transition.downToUp
              );
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
}
