import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'package:get/get.dart';
import 'package:movies_details/app/services/api_service.dart';

import '../../../data/models/movie/movie_collection_model.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/colors.dart';
import '../../../widgets/custom_divider.dart';
import '../../../widgets/custom_network_image.dart';
import '../../../widgets/movie_horizontal_card.dart';
import '../controllers/movie_collection_controller.dart';

class MovieCollectionView extends GetView<MovieCollectionController> {
  MovieCollectionView({super.key});

  final MovieCollectionController movieCollectionController = Get.find();

  @override
  Widget build(BuildContext context) {
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
          ])),
      child: SafeArea(
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Obx(() {
              if (movieCollectionController.collectionInfo.value == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                double screenWidth = MediaQuery.sizeOf(context).width;
                MovieCollection? collectionInfo =
                    movieCollectionController.collectionInfo.value;
                RxList<Parts> collectionMovies =
                    movieCollectionController.collectionMoviesList;
                String backdropImage(String path) =>
                    ApiService().imageUrl(path);

                return CustomScrollView(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverAppBar(
                      elevation: 0,
                      pinned: true,
                      stretch: true,
                      stretchTriggerOffset: 22,
                      expandedHeight: screenWidth < 700 ? 300.0 : 200.0,
                      toolbarHeight: 60,
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
                        child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: mainColor.withOpacity(0.5),
                                border: Border(
                                    bottom: BorderSide(
                                        width: 4, color: mainColor.shade900))),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 8.0),
                              child: Text(
                                '${collectionInfo?.name}',
                                style: Theme.of(context).textTheme.titleMedium,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )),
                      ),
                      flexibleSpace: Center(
                        child: CustomNetworkImage(
                          imgUrl: backdropImage(collectionInfo?.backdropPath ??
                              Icons.image.toString()),
                        ),
                      ),
                    ),
                    SliverPadding(
                        padding: const EdgeInsets.all(12.0),
                        sliver: SliverList(
                          delegate: SliverChildListDelegate([
                            collectionInfo?.overview == ''
                                ? const SizedBox()
                                : Text(
                                    '${collectionInfo?.overview}',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                            collectionInfo?.overview == ''
                                ? const SizedBox()
                                : const CustomDivider(),
                            Obx(() => Visibility(
                                  visible: collectionMovies.isNotEmpty,
                                  replacement:
                                      const CircularProgressIndicator(),
                                  // child: GridView.builder(
                                  //   shrinkWrap: true,
                                  //   physics: const BouncingScrollPhysics(),
                                  //   itemCount: collectionMovies.length,
                                  // gridDelegate:
                                  //     const SliverGridDelegateWithFixedCrossAxisCount(
                                  //   crossAxisCount: 2, // 2 items per row
                                  //   crossAxisSpacing:
                                  //       8.0, // Space between columns
                                  //   mainAxisSpacing:
                                  //       8.0, // Space between rows
                                  //   childAspectRatio:
                                  //       0.7, // Adjust based on the size of the items
                                  // ),
                                  //   itemBuilder: (context, index) {
                                  //     return MovieHorizontalCard(
                                  //       onTap: () {
                                  //         Get.delete<
                                  //             MovieCollectionController>();

                                  //         Get.toNamed(
                                  //           Routes.DETAILS,
                                  //           arguments:
                                  //               collectionMovies[index].id,
                                  //         );
                                  //       },
                                  //       image: backdropImage(
                                  //         collectionMovies[index].posterPath ??
                                  //             Icons.image.toString(),
                                  //       ),
                                  //       title:
                                  //           '${collectionMovies[index].title}',
                                  //       subTitleTop:
                                  //           '${collectionMovies[index].popularity?.toStringAsFixed(2)}',
                                  //       subTitleBottom:
                                  //           '${collectionMovies[index].releaseDate?.split('-').first}',
                                  //     );
                                  //   },
                                  // ),
                                  child: GridView.builder(
                                    shrinkWrap: true,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2, // 2 items per row
                                      crossAxisSpacing:
                                          8.0, // Space between columns
                                      mainAxisSpacing:
                                          58.0, // Space between rows
                                      // childAspectRatio:
                                      //     0.5, // Adjust based on the size of the items
                                    ),
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: collectionMovies.length,
                                    itemBuilder: (context, index) {
                                      return MovieHorizontalCard(
                                        onTap: () {
                                          Get.delete<
                                              MovieCollectionController>();

                                          Get.toNamed(
                                            Routes.DETAILS,
                                            arguments:
                                                collectionMovies[index].id,
                                          );
                                        },
                                        image: backdropImage(
                                            collectionMovies[index]
                                                    .posterPath ??
                                                Icons.image.toString()),
                                        title:
                                            '${collectionMovies[index].title}',
                                        subTitleTop:
                                            '${collectionMovies[index].popularity?.toStringAsFixed(2)}',
                                        subTitleBottom:
                                            '${collectionMovies[index].releaseDate?.split('-').first}',
                                      );
                                    },
                                    // separatorBuilder:
                                    //     (BuildContext context, int index) {
                                    //   return const Padding(
                                    //     padding: EdgeInsets.only(bottom: 6.0),
                                    //     child: CustomDivider(),
                                    //   );
                                    // },
                                  ),
                                ))
                          ]),
                        ))
                  ],
                );
              }
            })),
      ),
    );
  }
}
