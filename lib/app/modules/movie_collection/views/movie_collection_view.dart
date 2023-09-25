import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/movie_collection_controller.dart';

class MovieCollectionView extends GetView<MovieCollectionController> {
  MovieCollectionView({super.key});

  final MovieCollectionController movieCollectionController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MovieCollectionView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'MovieCollectionView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
