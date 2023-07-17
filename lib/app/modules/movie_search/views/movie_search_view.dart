import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:movies_details/app/services/api_service.dart';
import 'package:movies_details/app/utils/colors.dart';
import 'package:movies_details/app/widgets/custom_card.dart';

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

  String emptySearchText = 'Search a Movie';

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search for Movies'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: searchTEController,
                decoration: const InputDecoration(
                  labelText: 'Search',
                  hintText: 'Enter a movie name',
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () {
                  apiService.getSearchedMovie(searchTEController.text.trim());
                  FocusScope.of(context).requestFocus(FocusNode());

                  if(apiService.searchedMoviesList.isEmpty) {
                    emptySearchText = 'No movie found!';
                  }
                },
                child: const Text('Search', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
              ),
              Obx(()=> apiService.searchedMoviesList.isEmpty ? movieEmptyContainer() :
              GridView.builder(
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
                          genreNames: getGenreNames(index),
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
              )
              )
            ],
          ),
        ),
      )
    );
  }

  SizedBox movieEmptyContainer() => SizedBox(
    height: 300,
    width: 300,
    child: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.warning, size: 55, color: mainColor.shade400,),
          Text(emptySearchText, style: const TextStyle(fontSize: 18),)
        ],
      ),
    ),
  );

  List<String> getGenreNames(int index) {
    List<int> genreIdList = apiService.searchedMoviesList[index].genreIds!;
    var genreNames = detailsController.genres
        .where((genre) => genreIdList.contains(genre.id))
        .map((genre) => genre.name)
        .toList();
    return genreNames;
  }
}
