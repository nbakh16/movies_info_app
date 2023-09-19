import 'dart:async';
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

  RxList<Result> popularMoviesList = <Result>[].obs;
  RxList<Result> upcomingMoviesList = <Result>[].obs;
  RxList<Result> topRatedMoviesList = <Result>[].obs;

  void getMoviesByCategories(int page, String category, RxList<Result> movieList) async {
    movieList.clear();
    String responseUrl = '${baseUrl}movie/$category?page=$page&api_key=$apiKey';
    Response response = await get(Uri.parse(responseUrl));

    if(response.statusCode == 200) {
      Map<String, dynamic> decodedResponse = jsonDecode(response.body);

      for(var e in decodedResponse['results']) {
        movieList.add(
            Result.fromJson(e)
        );
      }
      movieList.refresh();
    }
    else {
      throw Exception('Failed to load movies list');
    }
  }

  @override
  void onInit() {
    super.onInit();
    //workaround to make initial loading smoother
    getMovies(pageNumber);
    Timer(const Duration(seconds: 1), (){
      getMoviesByCategories(pageNumber, 'popular', popularMoviesList);
      Timer(const Duration(seconds: 1), (){
        getMoviesByCategories(2, 'upcoming', upcomingMoviesList);
        Timer(const Duration(seconds: 2), (){
          getMoviesByCategories(pageNumber, 'top_rated', topRatedMoviesList);
        });
      });
    });
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
