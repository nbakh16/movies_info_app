import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:movies_details/app/modules/details/views/details_view.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/custom_drawer.dart';
import '../../details/controllers/details_controller.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  final HomeController homeController = Get.put(HomeController());
  final DetailsController detailsController = Get.put(DetailsController());

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Trending Movies'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            print(screenWidth);
          }, icon: const Icon(Icons.bug_report))
        ],
      ),
      drawer: SafeArea(
        child: CustomDrawer(),
      ),
      body: Obx(()=> homeController.isLoading.isTrue ? const CircularProgressIndicator() :
      GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: screenWidth<700 ? 2 : screenWidth<900 ? 3 : 4,
            childAspectRatio: 0.65
        ),
        itemCount: homeController.moviesList.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              homeController.getMovieCasts(homeController.moviesList[index].id);
              homeController.getMovieCrews(homeController.moviesList[index].id);

              Get.to(()=> DetailsView(
                movieName: homeController.moviesList[index].originalTitle,
                overview: homeController.moviesList[index].overview,
                backdropImagePath: homeController.moviesList[index].backdropPath,
                releaseDate: homeController.moviesList[index].releaseDate,
                voteAvg: homeController.moviesList[index].voteAverage,
                voteCount: homeController.moviesList[index].voteCount,
                genreNames: getGenreNames(index),
                castList: homeController.movieCastsList,
                crewList: homeController.movieCrewsList,
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
      )
    ));
  }

  List<String> getGenreNames(int index) {
    List<int> genreIdList = homeController.moviesList[index].genreIds;
    var genreNames = detailsController.genres
        .where((genre) => genreIdList.contains(genre.id))
        .map((genre) => genre.name)
        .toList();
    return genreNames;
  }
}
