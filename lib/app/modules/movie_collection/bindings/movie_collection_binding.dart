import 'package:get/get.dart';

import '../controllers/movie_collection_controller.dart';

class MovieCollectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MovieCollectionController>(
      () => MovieCollectionController(),
    );
  }
}
