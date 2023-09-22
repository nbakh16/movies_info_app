import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'package:get/get.dart';
import 'package:movies_details/app/services/api_service.dart';
import 'package:movies_details/app/utils/colors.dart';
import 'package:movies_details/app/widgets/custom_card_people.dart';
import 'package:movies_details/app/widgets/custom_network_image.dart';
import '../../../data/models/movie/movie_details_model.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/circular_icon_btn.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_divider.dart';
import '../../../widgets/people_list_widget.dart';
import '../controllers/details_controller.dart';

class DetailsView extends GetView<DetailsController> {
  DetailsView({Key? key}) : super(key: key);

  final DetailsController detailsController = Get.find();
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    late MovieDetails? movieInfo;

    apiService.getMovieCasts(detailsController.movieId);
    apiService.getMovieCrews(detailsController.movieId);
    apiService.getSimilarMovies(detailsController.movieId);

    var castList = apiService.movieCastsList;
    var similarMoviesList = apiService.similarMoviesList;

    double screenWidth = MediaQuery.sizeOf(context).width;

    Future<void> onRefresh() async {
      apiService.getMovieCasts(detailsController.movieId);
      apiService.getMovieCrews(detailsController.movieId);
      apiService.getSimilarMovies(detailsController.movieId);

      castList = apiService.movieCastsList;
      similarMoviesList = apiService.similarMoviesList;
    }

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
          body: RefreshIndicator(
            onRefresh: onRefresh,
            child: Obx((){
              if(detailsController.movieInfo.value == null) {
                return const Center(child: CircularProgressIndicator());
              }
              else if (detailsController.movieInfo.value == MovieDetails()) {
                return Center(child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text('No Data found!',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.yellowAccent
                    ),
                  ),
                ),);
              }
              else {
                movieInfo = detailsController.movieInfo.value;
                String backdropImage(String path) => 'https://image.tmdb.org/t/p/original$path';

                return CustomScrollView(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverAppBar(
                      elevation: 0,
                      pinned: true,
                      stretch: true,
                      stretchTriggerOffset: 22,
                      expandedHeight: screenWidth<700 ? 300.0 : 200.0,
                      toolbarHeight: 100,
                      leading: IconButton(
                        icon: const Icon(IconlyLight.arrowLeft2, size: 35),
                        onPressed: () => Get.back(),
                      ),
                      actions: [
                        IconButton(
                          icon: const Icon(IconlyLight.search, size: 35),
                          onPressed: () => Get.toNamed(Routes.MOVIE_SEARCH),
                        ),
                      ],
                      bottom: PreferredSize(
                        preferredSize: const Size.fromHeight(75),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            CircularIconButton(
                              onTap: () {
                                Get.toNamed(Routes.VIDEO,
                                    arguments: detailsController.movieId
                                );
                              },
                              icon: const Icon(Icons.play_arrow),
                            ),
                            Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: mainColor.withOpacity(0.5),
                                    border: Border(
                                        bottom: BorderSide(width: 4, color: mainColor.shade900)
                                    )
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                                  child: Text('${movieInfo?.title}', //movie.value.title!.toString(),
                                    style: Theme.of(context).textTheme.titleMedium,
                                  ),
                                )
                            ),
                          ],
                        ),
                      ),
                      flexibleSpace: Center(
                        child: CustomNetworkImage(
                          imgUrl: backdropImage(movieInfo?.backdropPath ?? Icons.image.toString()),
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.all(12.0),
                      sliver: SliverList(
                          delegate: SliverChildListDelegate (
                              [
                                releaseDataAndRatingRow(
                                    '${movieInfo?.releaseDate}', movieInfo?.voteCount ?? 0, movieInfo?.voteAverage ?? 0.0
                                ),
                                const CustomDivider(),
                                GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.zero,
                                  itemCount: movieInfo?.genres?.length,
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: screenWidth<700 ? 3 : screenWidth<900 ? 4 : 5,
                                    mainAxisExtent: 50,
                                    crossAxisSpacing: 3.0,
                                    mainAxisSpacing: 3.0,
                                  ),
                                  itemBuilder: (context, index) {
                                    var movieGenre = movieInfo?.genres;

                                    return Center(
                                      child: CustomButton(
                                        onTap: (){
                                          apiService.getMoviesListByGenre(movieGenre[index].id!, 1);
                                          Get.toNamed(Routes.MOVIES,
                                              arguments: {
                                                'moviesList': apiService.moviesListByGenre,
                                                'genreId': movieGenre[index].id,
                                                'genreName': movieGenre[index].name,
                                              },
                                          );
                                        },
                                        btnText: movieGenre![index].name.toString(),
                                      ),
                                    );
                                  }
                                ),
                                const CustomDivider(),
                                ExpandableText(
                                    '${movieInfo?.overview}',
                                    expandText: 'show more',
                                    collapseText: 'show less',
                                    maxLines: 4,
                                    linkColor: Colors.yellowAccent,
                                    animation: true,
                                    animationDuration: const Duration(seconds: 2),
                                    style: Theme.of(context).textTheme.bodyLarge,
                                    textAlign: TextAlign.justify,
                                    linkStyle: Theme.of(context).textTheme.bodyLarge
                                ),
                              ]
                          )
                      ),
                    ),
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
                                        Get.toNamed(Routes.CAST_DETAILS,
                                            arguments: castList[index].id
                                        );
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
                                        Get.delete<DetailsController>();

                                        detailsController.movieId = similarMoviesList[index].id;
                                        apiService.getMovieCasts(detailsController.movieId);
                                        apiService.getMovieCrews(detailsController.movieId);
                                        apiService.getSimilarMovies(detailsController.movieId);

                                        detailsController.getMovieInfo(detailsController.movieId);
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
                );
              }
            })
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
