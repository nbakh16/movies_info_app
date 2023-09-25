import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart';

import '../../../data/models/movie/movie_collection_model.dart';
import '../../../utils/api_key.dart';

class MovieCollectionController extends GetxController {
  String baseUrl = 'https://api.themoviedb.org/3/';
  var movieCollectionId = Get.arguments;

  RxList<Parts> moviesIdList = <Parts>[].obs;
  void getMoviesIdsFromCollection(int collectionId) async {
    String responseUrl = '${baseUrl}collection/$collectionId?language=en-US&api_key=$apiKey';
    final response = await get(Uri.parse(responseUrl));

    if(response.statusCode == 200) {
      Map<String, dynamic> decodedResponse = jsonDecode(response.body);

      for(var e in decodedResponse['parts']) {
        moviesIdList.add(
            Parts.fromJson(e)
        );
      }
    }
    else {
      throw Exception('Failed to load collections list');
    }
  }

  @override
  void onInit() {
    getMoviesIdsFromCollection(movieCollectionId);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
