import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'package:get/get.dart';
import 'package:movies_details/app/services/api_service.dart';
import 'package:movies_details/app/utils/colors.dart';
import 'package:movies_details/app/widgets/custom_card.dart';
import 'package:movies_details/app/widgets/custom_button.dart';

import '../../../routes/app_pages.dart';
import '../../details/controllers/details_controller.dart';
import '../controllers/movie_search_controller.dart';

class MovieSearchView extends GetView<MovieSearchController> {
  MovieSearchView({Key? key}) : super(key: key);

  final TextEditingController searchTEController = TextEditingController();
  final ApiService apiService = ApiService();

  // final HomeController homeController = Get.put(HomeController());

  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Search for Movies'),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(IconlyLight.arrowLeft2),
              onPressed: () => Get.back(),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    // TODO: Add validator
                    child: TextFormField(
                      controller: searchTEController,
                      focusNode: focusNode,
                      decoration: InputDecoration(
                          labelText: 'Search',
                          hintText: 'Enter a movie name',
                          suffixIcon: IconButton(
                              onPressed: () {
                                searchTEController.clear();
                                FocusScope.of(context).requestFocus(focusNode);
                              },
                              icon: Icon(
                                IconlyBold.closeSquare,
                                color: mainColor.shade200,
                              ))),
                      style: const TextStyle(color: Colors.white),
                      autofocus: true,
                      textInputAction: TextInputAction.search,
                      onEditingComplete: () => _searchResult(context),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  CustomButton(
                    onTap: () => _searchResult(context),
                    btnText: 'Search',
                    textSize: 20,
                    bgColor: mainColor,
                    shadowColor: mainColor.shade300,
                    btnElevation: 5,
                  ),
                  Obx(
                    () => Visibility(
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
          )),
    );
  }

  GridView searchedMoviesGridView(double screenWidth) {
    return GridView.builder(
        padding: const EdgeInsets.only(top: 14.0),
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
        itemCount: apiService.searchedMoviesList.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Get.toNamed(
                Routes.DETAILS,
                arguments: apiService.searchedMoviesList[index].id,
              );
              Get.put(DetailsController());
            },
            child: CustomCard(
              image: apiService.imageUrl(
                  apiService.searchedMoviesList[index].posterPath ?? ''),
              title: apiService.searchedMoviesList[index].title!,
              subTitle:
                  apiService.searchedMoviesList[index].voteAverage.toString(),
              subIcon: Icons.star,
            ),
          );
        });
  }

  Padding emptyListPlaceholder(context) {
    double resSize = MediaQuery.sizeOf(context).height * 0.2;
    return Padding(
      padding: EdgeInsets.only(top: resSize),
      child: Icon(
        IconlyBroken.infoCircle,
        size: resSize,
        color: mainColor.shade600,
      ),
    );
  }

  void _searchResult(BuildContext context) {
    apiService.getSearchedMovie(searchTEController.text.trim());
    FocusScope.of(context).unfocus();
  }
}
