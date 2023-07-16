import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:movies_details/app/modules/details/views/details_view.dart';
import '../../../utils/colors.dart';
import '../../../widgets/custom_network_image.dart';
import '../../details/controllers/details_controller.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  HomeController homeController = Get.put(HomeController());
  DetailsController detailsController = Get.put(DetailsController());

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;

    String getGenreNames(int index) {
      List<int> genreIdList = homeController.moviesList[index].genreIds;
      String genreNames = detailsController.genres
          .where((genre) => genreIdList.contains(genre.id))
          .map((genre) => genre.name)
          .toList().join(', ');
      return genreNames;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            print(screenWidth);
          }, icon: const Icon(Icons.bug_report))
        ],
      ),
      body: Obx(()=> homeController.isLoading.isTrue ? const CircularProgressIndicator() :
      GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: screenWidth<700 ? 2 : screenWidth<900 ? 3 : 4,
            childAspectRatio: 0.65
        ),
        itemCount: homeController.moviesList.length,
        //Image.network('${posterUrl}${moviesList[index].posterPath}',
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Get.to(()=> DetailsView(
                movieName: homeController.moviesList[index].originalTitle,
                overview: homeController.moviesList[index].overview,
                backdropImagePath: homeController.moviesList[index].backdropPath,
                releaseDate: homeController.moviesList[index].releaseDate,
                voteAvg: homeController.moviesList[index].voteAverage,
                voteCount: homeController.moviesList[index].voteCount,
                genreNames: getGenreNames(index),
              ),
                transition: Transition.downToUp
              );
            },
            child: Card(
                shape: const RoundedRectangleBorder(
                  side: BorderSide(
                    color: mainColor,
                  ),
                ),
                elevation: 4,
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            mainColor.shade700,
                            mainColor.shade700,
                            mainColor,
                            mainColor.shade400,
                          ]
                      )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          flex: 7,
                          child: CustomNetworkImage(
                            imgUrl: '${homeController.posterUrl}${homeController.moviesList[index].posterPath}'
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(homeController.moviesList[index].originalTitle.toString(),
                                  style: TextStyle(
                                    fontSize: screenWidth<400 ? 14 : screenWidth<700 ? 16 : 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const Icon(Icons.star, size: 14,),
                                    Text(homeController.moviesList[index].voteAverage.toString()),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
            ),
          );
        },
      )
    ));
  }
}
