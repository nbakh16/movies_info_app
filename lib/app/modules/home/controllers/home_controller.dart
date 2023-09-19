import 'dart:convert';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart';
import '../../../data/models/movies_model.dart';
import '../../../utils/api_key.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  int pageNumber = 1;

  String baseUrl = 'https://api.themoviedb.org/3/';
  String baseImageUrl = 'https://image.tmdb.org/t/p/original';

  ///trending movies
  RxList<Result> moviesList = <Result>[].obs;
  void getMovies(int page) async {
    moviesList.clear();
    String moviesListUrl = '${baseUrl}discover/movie?page=$page&api_key=$apiKey';
    Response response = await get(Uri.parse(moviesListUrl));

    if(response.statusCode == 200) {
      Map<String, dynamic> decodedResponse = jsonDecode(response.body);

      for(var e in decodedResponse['results']) {
        moviesList.add(
            Result.fromJson(e)
        );
      }
      moviesList.refresh();
    }
    else {
      throw Exception('Failed to load movies list');
    }
  }

  ///upcoming movies
  RxList<Result> upcomingMoviesList = <Result>[].obs;
  void getUpcomingMovies(int page) async {
    upcomingMoviesList.clear();
    String responseUrl = '${baseUrl}movie/upcoming?page=$page&api_key=$apiKey';
    Response response = await get(Uri.parse(responseUrl));

    if(response.statusCode == 200) {
      Map<String, dynamic> decodedResponse = jsonDecode(response.body);

      for(var e in decodedResponse['results']) {
        upcomingMoviesList.add(
            Result.fromJson(e)
        );
      }
      upcomingMoviesList.refresh();
    }
    else {
      throw Exception('Failed to load movies list');
    }
  }

  ///top movies
  RxList<Result> topRatedMoviesList = <Result>[].obs;
  void getTopRatedMovies(int page) async {
    topRatedMoviesList.clear();
    String responseUrl = '${baseUrl}movie/top_rated?page=$page&api_key=$apiKey';
    Response response = await get(Uri.parse(responseUrl));

    if(response.statusCode == 200) {
      Map<String, dynamic> decodedResponse = jsonDecode(response.body);

      for(var e in decodedResponse['results']) {
        topRatedMoviesList.add(
            Result.fromJson(e)
        );
      }
      topRatedMoviesList.refresh();
    }
    else {
      throw Exception('Failed to load movies list');
    }
  }

  @override
  void onInit() {
    super.onInit();
    getMovies(pageNumber);
    getUpcomingMovies(pageNumber);
    getTopRatedMovies(pageNumber);
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
