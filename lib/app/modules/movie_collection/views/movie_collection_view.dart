import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../utils/colors.dart';
import '../../../widgets/custom_network_image.dart';
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
              ]
          )
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Obx((){
            if(movieCollectionController.collectionInfo.value == null) {
              return Center(child: CircularProgressIndicator());
            }
            else {
              double screenWidth = MediaQuery.sizeOf(context).width;
              var collectionInfo = movieCollectionController.collectionInfo.value;
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
                      child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: mainColor.withOpacity(0.5),
                              border: Border(
                                  bottom: BorderSide(width: 4, color: mainColor.shade900)
                              )
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                            child: Text('${collectionInfo?.name}',
                              style: Theme.of(context).textTheme.titleMedium,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                      ),
                    ),
                    flexibleSpace: Center(
                      child: CustomNetworkImage(
                        imgUrl: backdropImage(collectionInfo?.backdropPath ?? Icons.image.toString()),
                      ),
                    ),
                  ),
                ],
              );
            }
          })
        ),
      ),
    );
  }
}
