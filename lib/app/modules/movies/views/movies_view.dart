import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:movies_details/app/modules/details/controllers/details_controller.dart';
import 'package:movies_details/app/widgets/custom_app_bar.dart';
import 'package:movies_details/app/widgets/shimmer_loading/movie_view_shimmer.dart';

import '../../../data/models/movie/movies_model.dart';
import '../../../routes/app_pages.dart';
import '../../../services/api_service.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/custom_drawer.dart';
import '../../../widgets/two_btn_row_widget.dart';

class MoviesView extends StatelessWidget {
  MoviesView({super.key});

  final RxList<Result>? moviesList = Get.arguments['moviesList'];
  final int? genreId = Get.arguments['genreId'];
  final String? genreName = Get.arguments['genreName'];

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
            child: Obx(() => Visibility(
                  visible: moviesList!.isNotEmpty,
                  replacement: const MovieViewShimmerLoading(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //pageChangeButtons(),
                      moviesListGridView(screenWidth),
                      //pageChangeButtons(),
                    ],
                  ),
                )),
          )),
        ));
  }

  GridView moviesListGridView(double screenWidth) {
    return GridView.builder(
      physics: const ScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: screenWidth < 700
              ? 2
              : screenWidth < 900
                  ? 3
                  : 4,
          childAspectRatio: 0.65),
      itemCount: moviesList!.length,
      itemBuilder: (context, index) {
        return InkWell(
            onTap: () {
              Get.delete<DetailsController>();
              Get.toNamed(
                Routes.DETAILS,
                arguments: moviesList![index].id,
              );
            },
            child: CustomCard(
              image: apiService.imageUrl(moviesList![index].posterPath ?? ''),
              title: moviesList![index].title.toString(),
              subTitle: moviesList![index].voteAverage.toString(),
              subIcon: Icons.star,
            ));
      },
    );
  }

  //TODO: Fix page change
  Obx pageChangeButtons() {
    return Obx(
      () => TwoButtonRowWidget(
        btnLeftOnTap: () {
          if (counter > 1) {
            counter--;
            moviesList!.clear();
            apiService.getMoviesListByGenre(genreId!, counter.value);
            moviesList!.addAll(apiService.moviesListByGenre);
          }
        },
        btnRightOnTap: () {
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
