import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../../utils/api_key.dart';
import '../../../utils/colors.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            print(screenWidth);
          }, icon: Icon(Icons.refresh))
        ],
      ),
      body: Obx(()=> homeController.isLoading.isTrue ? CircularProgressIndicator() :
      GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: screenWidth<700 ? 2 : screenWidth<900 ? 3 : 4,
            childAspectRatio: 0.65
        ),
        itemCount: homeController.moviesList.length,
        //Image.network('${posterUrl}${moviesList[index].posterPath}',
        itemBuilder: (context, index) {
          return Card(
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
                        child: Image.network('${homeController.posterUrl}${homeController.moviesList[index].posterPath}',
                          alignment: Alignment.center,
                          height: double.infinity,
                          width: double.infinity,
                          fit: BoxFit.fitWidth,
                          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loading) {
                            if (loading == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loading.expectedTotalBytes != null
                                    ? loading.cumulativeBytesLoaded/loading.expectedTotalBytes! : null,
                              ),
                            );
                          },
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
          );
        },
      )
    ));
  }
}
