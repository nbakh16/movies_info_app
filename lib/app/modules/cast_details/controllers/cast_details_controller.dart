import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:movies_details/app/data/models/cast/cast_bio_model.dart';

import '../../../data/models/movie/movies_model.dart';
import '../../../utils/api_key.dart';

class CastDetailsController extends GetxController {
  String baseUrl = 'https://api.themoviedb.org/3/';
  final castId = Get.arguments;

  ///get cast info
  Rx<CastBio?> castInfo = Rx<CastBio?>(null);
  Future<void> getCastInfo(int castId) async {
    final String responseUrl = '${baseUrl}person/$castId?api_key=$apiKey';

    final response = await get(Uri.parse(responseUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      castInfo.value = CastBio.fromJson(data);
    } else {
      throw Exception('Failed to load actor data');
    }
  }

  ///get cast movie list
  RxList<Result> castMoviesList = <Result>[].obs;
  Future<void> getCastMovies(int castId) async {
    castMoviesList.clear();
    String responseUrl = '${baseUrl}person/$castId/movie_credits?api_key=$apiKey';
    final response = await get(Uri.parse(responseUrl));

    if(response.statusCode == 200) {
      Map<String, dynamic> decodedResponse = jsonDecode(response.body);

      for(var e in decodedResponse['cast']) {
        castMoviesList.add(
            Result.fromJson(e)
        );
      }
      castMoviesList.refresh();
    }
    else {
      throw Exception('Failed to load movies list');
    }
  }

  @override
  void onInit() {
    getCastInfo(castId);
    getCastMovies(castId);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
