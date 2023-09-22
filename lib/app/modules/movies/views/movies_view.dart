import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:movies_details/app/widgets/custom_app_bar.dart';
import 'package:movies_details/app/widgets/shimmer_loading/movie_view_shimmer.dart';

import '../../../data/models/movie/movies_model.dart';
import '../../../routes/app_pages.dart';
import '../../../services/api_service.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/custom_drawer.dart';
import '../../../widgets/two_btn_row_widget.dart';
import '../controllers/movies_controller.dart';

class MoviesView extends GetView<MoviesController> {
  MoviesView({Key? key}) : super(key: key);

  RxList<Result>? moviesList = Get.arguments['moviesList'];
  int? genreId = Get.arguments['genreId'];
  String? genreName = Get.arguments['genreName'];

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
                      replacement: const MovieViewShimmerLoading(),
                      child:
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              //pageChangeButtons(),
                              moviesListGridView(screenWidth),
                              //pageChangeButtons(),
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
              Get.toNamed(Routes.DETAILS,
                  arguments: moviesList![index],
              );
            },
            child: CustomCard(
              image: '${apiService.baseImageUrl}${moviesList![index].posterPath}',
              title: moviesList![index].title.toString(),
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
