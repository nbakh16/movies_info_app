import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:movies_details/app/data/models/genre_model.dart';
import 'package:movies_details/app/modules/movies/views/movies_view.dart';
import 'package:movies_details/app/services/api_service.dart';
import 'package:movies_details/app/utils/colors.dart';
import 'package:movies_details/app/widgets/custom_card_people.dart';
import 'package:movies_details/app/widgets/custom_network_image.dart';
import 'package:movies_details/app/widgets/custom_button.dart';

import '../../../data/models/cast_model.dart';
import '../../../data/models/movies_model.dart';
import '../../../widgets/custom_divider.dart';
import '../../../widgets/people_list_widget.dart';
import '../controllers/details_controller.dart';

class DetailsView extends GetView<DetailsController> {
  String? movieName, overview, backdropImagePath, releaseDate;
  double? voteAvg;
  int? voteCount;
  List<GenreElement>? movieGenre;
  RxList<Cast>? castList;
  RxList<Crew>? crewList;
  RxList<Result>? similarMoviesList;

  DetailsView({
    this.movieName,
    this.overview,
    this.backdropImagePath,
    this.releaseDate,
    this.voteAvg,
    this.voteCount,
    this.movieGenre,
    this.castList,
    this.crewList,
    this.similarMoviesList,
    Key? key}) : super(key: key);

  DetailsController detailsController = Get.put(DetailsController());
  ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    String backdropImage = 'https://image.tmdb.org/t/p/original$backdropImagePath';

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
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: CustomScrollView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              // title: Text('Movie Name'),
              toolbarHeight: 100,
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
                      child: Text(movieName!.toString(),
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
              flexibleSpace: CustomNetworkImage(imgUrl: backdropImage,),
              // flexibleSpace: Positioned.fill(
              //     child: CustomNetworkImage(imgUrl: backdropImage,)
              // ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(12.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate (
                  [
                    releaseDataAndRatingRow(
                        releaseDate!.toString(), voteCount!, voteAvg!
                    ),
                    const CustomDivider(),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: movieGenre!.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: screenWidth<700 ? 3 : screenWidth<900 ? 4 : 5,
                        mainAxisExtent: 50,
                        crossAxisSpacing: 3.0,
                        mainAxisSpacing: 3.0,
                      ),
                      itemBuilder: (context, index) {
                        return Center(
                          child: CustomButton(
                            onTap: (){
                              apiService.getMoviesListByGenre(movieGenre![index].id, 1);
                              Get.off(()=>MoviesView(
                                  moviesList: apiService.moviesListByGenre,
                                  genreId: movieGenre![index].id,
                                  genreName: movieGenre![index].name,
                                ),
                                transition: Transition.fadeIn
                              );
                            },
                            btnText: movieGenre![index].name,
                          ),
                        );
                      }
                    ),
                    const CustomDivider(),
                    Text(overview!.toString(),
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.justify,
                    ),
                  ]
                )
              ),
            ),
            // TODO: Fix ListView for landscape orientation
            Obx(()=>
                Visibility(
                  visible: castList!.isNotEmpty,
                  replacement: const SliverToBoxAdapter(),
                  child: PeopleListWidget(
                    category: 'Cast(s)',
                    listView: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: castList!.length,
                      itemBuilder: (context, index){
                        return CustomCardPeople(
                          image: 'https://image.tmdb.org/t/p/original${castList![index].profilePath}',
                          title: castList![index].name.toString().trim(),
                          subTitle: castList![index].character.toString().trim(),
                          // subTitle: '(${crewList![index].job})',
                        );
                      }
                    )
                  ),
                )
            ),
            Obx(()=>
                Visibility(
                  visible: similarMoviesList!.isNotEmpty,
                  replacement: const SliverToBoxAdapter(),
                  child: PeopleListWidget(
                    category: 'Related Movies',
                    listView: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: similarMoviesList!.length,
                      itemBuilder: (context, index){
                        return CustomCardPeople(
                          onTap: () {
                            // similarMoviesList!.clear();
                            // apiService.getMovieCasts(similarMoviesList![index].id!);
                            // apiService.getMovieCrews(similarMoviesList![index].id!);
                            // apiService.getSimilarMovies(similarMoviesList![index].id!);
                            //
                            //
                            // similarMoviesList!.isEmpty ? CircularProgressIndicator() :
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => Obx(() =>
                            //     DetailsView(
                            //     movieName: similarMoviesList![index].originalTitle,
                            //   )
                            //   )
                            //   ),
                            // );
                            // movieName= similarMoviesList![index].originalTitle;
                            // overview= similarMoviesList![index].overview;
                            // backdropImagePath= similarMoviesList![index].backdropPath;
                            // releaseDate= similarMoviesList![index].releaseDate;
                            // voteAvg= similarMoviesList![index].voteAverage;
                            // voteCount= similarMoviesList![index].voteCount;
                            // movieGenre= getGenreListOfMovie(index);
                            // castList= apiService.movieCastsList;
                            // crewList= apiService.movieCrewsList;
                            // similarMoviesList= apiService.similarMoviesList;
                          },
                          image: 'https://image.tmdb.org/t/p/original${similarMoviesList![index].posterPath}',
                          title: similarMoviesList![index].originalTitle.toString().trim(),
                          subTitle: similarMoviesList![index].voteAverage.toString().trim(),
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

  List<GenreElement> getGenreListOfMovie(int index) {
    List<int> genreIdList = similarMoviesList![index].genreIds!;

    var genreListOfMovie = detailsController.genreList
        .where((genre) => genreIdList
        .contains(genre.id))
        .toList();

    return genreListOfMovie;
  }
}
