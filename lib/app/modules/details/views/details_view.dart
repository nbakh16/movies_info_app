import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'package:get/get.dart';
import 'package:movies_details/app/services/api_service.dart';
import 'package:movies_details/app/utils/colors.dart';
import 'package:movies_details/app/widgets/custom_card_people.dart';
import 'package:movies_details/app/widgets/custom_network_image.dart';
import 'package:movies_details/app/widgets/custom_button.dart';

import '../../../data/models/movies_model.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/custom_divider.dart';
import '../../../widgets/people_list_widget.dart';
import '../../home/views/home_view.dart';
import '../controllers/details_controller.dart';

class DetailsView extends GetView<DetailsController> {
  DetailsView({Key? key}) : super(key: key);

  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    final selectedMovie = Get.arguments as Result;

    final Rx<Result> movie = selectedMovie.obs;
    apiService.getMovieCasts(movie.value.id!);
    apiService.getMovieCrews(movie.value.id!);
    apiService.getSimilarMovies(movie.value.id!);

    var castList = apiService.movieCastsList;
    var similarMoviesList = apiService.similarMoviesList;

    double screenWidth = MediaQuery.sizeOf(context).width;
    String backdropImage(String path) => 'https://image.tmdb.org/t/p/original$path';

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            mainColor,
            mainColor,
            mainColor,
            mainColor.shade600,
            mainColor.shade700,
            mainColor.shade800,
            mainColor.shade900
          ]
        )
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: CustomScrollView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            slivers: [
              Obx(()=>SliverAppBar(
                // title: Text('Movie Name'),
                toolbarHeight: 100,
                leading: IconButton(
                  icon: Icon(IconlyLight.arrowLeft2,
                      size: MediaQuery.sizeOf(context).height * 0.05),
                  onPressed: () => Get.back(),
                ),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(10),
                  child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: mainColor.withOpacity(0.5),
                          border: Border(
                              bottom: BorderSide(width: 4, color: mainColor.shade900)
                          )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(movie.value.title!.toString(),
                          style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      )
                  ),
                ),
                elevation: 0,
                pinned: true,
                stretch: true,
                stretchTriggerOffset: 22,
                expandedHeight: 300.0,
                flexibleSpace: Center(
                    child: CustomNetworkImage(
                      imgUrl: backdropImage(movie.value.backdropPath ?? Icons.image.toString()),
                    ),
                  ),
                  // flexibleSpace: Positioned.fill(
                //     child: CustomNetworkImage(imgUrl: backdropImage,)
                // ),
              ),),
              Obx(()=> SliverPadding(
                padding: const EdgeInsets.all(12.0),
                sliver: SliverList(
                    delegate: SliverChildListDelegate (
                        [
                          releaseDataAndRatingRow(
                              movie.value.releaseDate!.toString(), movie.value.voteCount!, movie.value.voteAverage!
                          ),
                          const CustomDivider(),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemCount: HomeView().getGenreListOfMovie(movie.value.genreIds!).length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: screenWidth<700 ? 3 : screenWidth<900 ? 4 : 5,
                              mainAxisExtent: 50,
                              crossAxisSpacing: 3.0,
                              mainAxisSpacing: 3.0,
                            ),
                            itemBuilder: (context, index) {
                              var movieGenre = HomeView().getGenreListOfMovie(movie.value.genreIds!);

                              return Center(
                                child: CustomButton(
                                  onTap: (){
                                    apiService.getMoviesListByGenre(movieGenre[index].id, 1);
                                    Get.toNamed(Routes.MOVIES,
                                        arguments: {
                                          'moviesList': apiService.moviesListByGenre,
                                          'genreId': movieGenre[index].id,
                                          'genreName': movieGenre[index].name,
                                        },
                                    );
                                  },
                                  btnText: movieGenre[index].name,
                                ),
                              );
                            }
                          ),
                          const CustomDivider(),
                          Text(movie.value.overview.toString(),
                            style: const TextStyle(fontSize: 16),
                            textAlign: TextAlign.justify,
                          ),
                        ]
                    )
                ),
              ),),
              // TODO: Fix ListView for landscape orientation
              Obx(()=>
                  Visibility(
                    visible: castList.isNotEmpty,
                    replacement: const SliverToBoxAdapter(),
                    child: PeopleListWidget(
                      category: 'Cast(s)',
                      listView: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: castList.length,
                        itemBuilder: (context, index){
                          return CustomCardPeople(
                            onTap: () {
                              Get.toNamed(Routes.CAST_DETAILS);
                            },
                            image: 'https://image.tmdb.org/t/p/original${castList[index].profilePath}',
                            title: castList[index].name.toString().trim(),
                            subTitle: castList[index].character.toString().trim(),
                            // subTitle: '(${crewList![index].job})',
                          );
                        }
                      )
                    ),
                  )
              ),
              Obx(()=>
                  Visibility(
                    visible: similarMoviesList.isNotEmpty,
                    replacement: const SliverToBoxAdapter(),
                    child: PeopleListWidget(
                      category: 'Related Movies',
                      listView: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: similarMoviesList.length,
                        itemBuilder: (context, index){
                          return CustomCardPeople(
                            onTap: () {
                              movie.value = similarMoviesList[index];
                              apiService.getMovieCasts(movie.value.id!);
                              apiService.getMovieCrews(movie.value.id!);
                              apiService.getSimilarMovies(movie.value.id!);
                            },
                            image: 'https://image.tmdb.org/t/p/original${similarMoviesList[index].posterPath}',
                            title: similarMoviesList[index].title.toString().trim(),
                            subTitle: similarMoviesList[index].voteAverage.toString().trim(),
                            subIcon: Icons.star,
                            // subTitle: '(${crewList![index].job})',
                          );
                        }
                      )
                    ),
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row releaseDataAndRatingRow(
      String releaseDate, int voteCount, double voteAvg
      ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(releaseDate.toString()),
        Row(
          children: [
            const Icon(Icons.star, size: 26,),
            Column(
              children: [
                Text('$voteAvg/10',
                  style: const TextStyle(fontWeight: FontWeight.w900),),
                Text(voteCount.toString(),
                  style: const TextStyle(fontWeight: FontWeight.w400),)
              ],
            )
          ],
        )
      ],
    );
  }
}
