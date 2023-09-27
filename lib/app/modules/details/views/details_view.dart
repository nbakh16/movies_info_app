import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'package:get/get.dart';
import 'package:movies_details/app/data/models/movie/belongs_to_collection.dart';
import 'package:movies_details/app/modules/details/views/widgets/elements_list_widget.dart';
import 'package:movies_details/app/modules/details/views/widgets/release_rating_duration.dart';
import 'package:movies_details/app/services/api_service.dart';
import 'package:movies_details/app/utils/colors.dart';
import 'package:movies_details/app/utils/language_code.dart';
import 'package:movies_details/app/utils/number_formatter.dart';
import 'package:movies_details/app/widgets/custom_card_people.dart';
import 'package:movies_details/app/widgets/custom_network_image.dart';
import 'package:movies_details/app/widgets/label_and_text.dart';
import '../../../data/models/cast/cast_model.dart';
import '../../../data/models/movie/movie_details_model.dart';
import '../../../data/models/movie/movies_model.dart';
import '../../../data/models/movie/production_companies.dart';
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

    RxList<Cast> castList = apiService.movieCastsList;
    RxList<Crew> crewList = apiService.movieCrewsList;
    RxList<Result> similarMoviesList = apiService.similarMoviesList;

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

                Rx<List<ProductionCompanies>?>? productionCompanies = movieInfo?.productionCompanies.obs;
                Rx<BelongsToCollection?>? movieInCollection = movieInfo?.belongsToCollection.obs;

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
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CircularIconButton(
                                  onTap: () {
                                    Get.toNamed(Routes.VIDEO,
                                        arguments: detailsController.movieId
                                    );
                                  },
                                  icon: const Icon(Icons.play_arrow),
                                ),

                                movieInfo?.homepage == null ? const SizedBox() :
                                CircularIconButton(
                                  onTap: () {
                                    Get.toNamed(Routes.WEB_VIEW,
                                        arguments: movieInfo?.homepage
                                    );
                                  },
                                  icon: const Icon(Icons.link),
                                ),
                              ],
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
                                  child: Text('${movieInfo?.title}',
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
                                movieInfo?.tagline == '' ? const SizedBox() :
                                Text('${movieInfo?.tagline}',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                movieInfo?.tagline == '' ? const SizedBox() :
                                const CustomDivider(),

                                ReleaseRatingDuration(
                                  releaseDate: movieInfo?.releaseDate ?? '',
                                  voteCount: movieInfo?.voteCount ?? 0,
                                  voteAvg: movieInfo?.voteAverage ?? 0.0,
                                  duration: movieInfo?.runtime ?? 0
                                ),
                                const CustomDivider(),

                                genreGridView(movieInfo, screenWidth),
                                const CustomDivider(),

                                LabelAndText(label: 'Language', text: '${languageMap[movieInfo?.originalLanguage]}'),
                                movieInfo?.budget == 0 ? const SizedBox() :
                                LabelAndText(label: 'Budget', text: NumberFormatter().formatCurrency(movieInfo!.budget ?? 0)),
                                movieInfo?.revenue == 0 ? const SizedBox() :
                                LabelAndText(label: 'Revenue', text: NumberFormatter().formatCurrency(movieInfo!.revenue ?? 0)),
                                const CustomDivider(),

                                overviewText(movieInfo, context),
                              ]
                          )
                      ),
                    ),
                    Obx(()=>
                        Visibility(
                          visible: castList.isNotEmpty,
                          replacement: const SliverToBoxAdapter(),
                          child: ElementsListWidget(
                            title: 'Top Cast',
                            elementsList: castList,
                          )
                        )
                    ),
                    Obx(()=>
                        Visibility(
                          visible: crewList.isNotEmpty,
                          replacement: const SliverToBoxAdapter(),
                          child: ElementsListWidget(
                            title: 'Crew',
                            elementsList: crewList,
                            isCast: false,
                          )
                        )
                    ),
                    Obx(()=>
                        Visibility(
                          visible: productionCompanies!.value!.isNotEmpty,
                          replacement: const SliverToBoxAdapter(),
                          child: PeopleListWidget(
                              category: 'Production(s)',
                              listView: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: productionCompanies.value?.length,
                                  itemBuilder: (context, index){
                                    ProductionCompanies productions = productionCompanies.value![index];
                                    return CustomCardPeople(
                                      onTap: () {
                                        //TODO: company details api on showDialog
                                      },
                                      image: 'https://image.tmdb.org/t/p/original${productions.logoPath}',
                                      title: productions.name.toString().trim(),
                                    );
                                  }
                              )
                          ),
                        )
                    ),
                    Visibility(
                      visible: movieInfo?.belongsToCollection != null,
                      replacement: const SliverToBoxAdapter(),
                      child: PeopleListWidget(
                          category: 'Belongs To',
                          height: 150,
                          listView: InkWell(
                            onTap: () {
                              Get.delete<DetailsController>();

                              Get.toNamed(Routes.MOVIE_COLLECTION,
                                arguments: movieInfo?.belongsToCollection?.id
                              );
                            },
                            child: SizedBox(
                                width: double.infinity,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    ColorFiltered(
                                      colorFilter: ColorFilter.mode(mainColor.shade800.withOpacity(0.55), BlendMode.darken),
                                      child: CustomNetworkImage(
                                        imgUrl: 'https://image.tmdb.org/t/p/original${movieInCollection?.value?.backdropPath}',
                                      ),
                                    ),
                                    Text('${movieInCollection?.value?.name}',
                                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                          fontWeight: FontWeight.w900,
                                          letterSpacing: 2.5
                                      ),
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                )
                            ),
                          )
                      ),
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

                                        Navigator.pushNamed(
                                          context,
                                          Routes.DETAILS,
                                          arguments: similarMoviesList[index].id,
                                        );

                                        // detailsController.movieId = similarMoviesList[index].id;
                                        // apiService.getMovieCasts(detailsController.movieId);
                                        // apiService.getMovieCrews(detailsController.movieId);
                                        // apiService.getSimilarMovies(detailsController.movieId);
                                        //
                                        // detailsController.getMovieInfo(detailsController.movieId);
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

  ExpandableText overviewText(MovieDetails? movieInfo, BuildContext context) {
    return ExpandableText(
        '${movieInfo?.overview}',
        expandText: 'show more',
        collapseText: 'show less',
        maxLines: 5,
        linkColor: Colors.yellowAccent,
        animation: true,
        animationDuration: const Duration(seconds: 2),
        style: Theme.of(context).textTheme.bodyLarge,
        textAlign: TextAlign.justify,
        linkStyle: Theme.of(context).textTheme.bodyLarge
    );
  }

  GridView genreGridView(MovieDetails? movieInfo, double screenWidth) {
    return GridView.builder(
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
    );
  }
}
