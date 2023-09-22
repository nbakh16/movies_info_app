import 'dart:convert';

import 'package:get/get.dart';
import '../../../data/models/movie/movie_details_model.dart';
import '../../../utils/api_key.dart';
import 'package:http/http.dart';

class DetailsController extends GetxController {
  String baseUrl = 'https://api.themoviedb.org/3/';
  var movieId = Get.arguments;

  ///get movie info
  Rx<MovieDetails?> movieInfo = Rx<MovieDetails?>(null);
  Future<void> getMovieInfo(int movieId) async {
    final String responseUrl = '${baseUrl}movie/$movieId?api_key=$apiKey';

    final response = await get(Uri.parse(responseUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      movieInfo.value = MovieDetails.fromJson(data);
    } else {
      throw Exception('Failed to load movie data');
    }
  }

  @override
  void onInit() {
    super.onInit();
    getMovieInfo(movieId);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

}
