import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:movies_details/app/services/api_service.dart';
import 'package:movies_details/app/utils/colors.dart';
import 'package:movies_details/app/widgets/custom_card.dart';
import 'package:movies_details/app/widgets/custom_button.dart';

import '../../../data/models/genre_model.dart';
import '../../details/controllers/details_controller.dart';
import '../../details/views/details_view.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/movie_search_controller.dart';

class MovieSearchView extends GetView<MovieSearchController> {
  MovieSearchView({Key? key}) : super(key: key);

  final TextEditingController searchTEController = TextEditingController();
  final ApiService apiService = ApiService();

  final HomeController homeController = Get.put(HomeController());
  final DetailsController detailsController = Get.put(DetailsController());

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Search for Movies'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  // TODO: Add validator
                  child: TextFormField(
                    controller: searchTEController,
                    decoration: const InputDecoration(
                      labelText: 'Search',
                      hintText: 'Enter a movie name',
                    ),
                    style: const TextStyle(color: Colors.white),
                    autofocus: true,
                    textInputAction: TextInputAction.search,
                  ),
                ),
                const SizedBox(height: 10.0),
                CustomButton(
                  onTap: () {
                    apiService.getSearchedMovie(searchTEController.text.trim());
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  btnText: 'Search',
                  textSize: 20,
                  bgColor: mainColor,
                  shadowColor: mainColor.shade300,
                  btnElevation: 5,
                ),
                Obx(()=>
                  Visibility(
                    visible: apiService.searchedMoviesList.isNotEmpty,
                    replacement: emptyListPlaceholder(context),
                    child: searchedMoviesGridView(screenWidth),
                  ),
                ),
                // Obx(()=> apiService.searchedMoviesList.isEmpty ? emptyListPlaceholder() :
                //   searchedMoviesGridView(screenWidth)
                // )
              ],
            ),
          ),
        )
      ),
    );
  }

  GridView searchedMoviesGridView(double screenWidth) {
    return GridView.builder(
      padding: const EdgeInsets.only(top: 14.0),
      physics: const ScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: screenWidth<700 ? 2 : screenWidth<900 ? 3 : 4,
          childAspectRatio: 0.65
      ),
      itemCount: apiService.searchedMoviesList.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            apiService.getMovieCasts(apiService.searchedMoviesList[index].id!);
            apiService.getMovieCrews(apiService.searchedMoviesList[index].id!);
            apiService.getSimilarMovies(apiService.searchedMoviesList[index].id!);


            Get.to(()=> DetailsView(
              movieName: apiService.searchedMoviesList[index].originalTitle,
              overview: apiService.searchedMoviesList[index].overview,
              backdropImagePath: apiService.searchedMoviesList[index].backdropPath,
              releaseDate: apiService.searchedMoviesList[index].releaseDate,
              voteAvg: apiService.searchedMoviesList[index].voteAverage,
              voteCount: apiService.searchedMoviesList[index].voteCount,
              movieGenre: getGenreListOfMovie(index),
              castList: apiService.movieCastsList,
              crewList: apiService.movieCrewsList,
              similarMoviesList: apiService.similarMoviesList,
            ),
                transition: Transition.downToUp
            );
          },
          child: CustomCard(
            image: '${apiService.baseImageUrl}${apiService.searchedMoviesList[index].posterPath}',
            title: apiService.searchedMoviesList[index].originalTitle!,
            subTitle: apiService.searchedMoviesList[index].voteAverage.toString(),
            subIcon: Icons.star,
          ),
        );
      }
    );
  }

  Padding emptyListPlaceholder(context) {
    double resSize = MediaQuery.sizeOf(context).height * 0.2;
    return Padding(
        padding: EdgeInsets.only(top: resSize),
        child: Icon(Icons.info_outline,
          size: resSize,
          color: mainColor.shade600,
        ),
      );
  }

  List<GenreElement> getGenreListOfMovie(int index) {
    List<int> genreIdList = apiService.searchedMoviesList[index].genreIds!;

    var genreListOfMovie = detailsController.genreList
        .where((genre) => genreIdList
        .contains(genre.id))
        .toList();

    return genreListOfMovie;
  }
}
