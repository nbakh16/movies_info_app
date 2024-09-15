import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart';
import '../../../data/models/movie/movies_model.dart';
import '../../../utils/api_key.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  int pageNumber = 1;

  String baseUrl = 'https://api.themoviedb.org/3/';
  String baseImageUrl = 'https://image.tmdb.org/t/p/original';

  ///trending movies
  RxList<Result> moviesList = <Result>[].obs;
  Future<void> getMovies(int page) async {
    moviesList.clear();
    String moviesListUrl =
        '${baseUrl}discover/movie?page=$page&api_key=$apiKey';
    var response = await get(Uri.parse(moviesListUrl));

    if (response.statusCode == 200) {
      Map<String, dynamic> decodedResponse = jsonDecode(response.body);

      for (var e in decodedResponse['results']) {
        moviesList.add(Result.fromJson(e));
      }
      moviesList.refresh();
    } else {
      throw Exception('Failed to load movies list');
    }
  }

  RxList<Result> popularMoviesList = <Result>[].obs;
  RxList<Result> upcomingMoviesList = <Result>[].obs;
  RxList<Result> topRatedMoviesList = <Result>[].obs;

  RxBool hasMovies = true.obs;
  RxBool hasPopularMovies = true.obs;
  RxBool hasUpcomingMovies = true.obs;
  RxBool hasTopMovies = true.obs;

  Future<void> getMoviesByCategories({
    required int page,
    required String category,
    required RxList<Result> movieList,
  }) async {
    movieList.clear();
    String responseUrl = '${baseUrl}movie/$category?page=$page&api_key=$apiKey';
    var response = await get(Uri.parse(responseUrl));

    if (response.statusCode == 200) {
      Map<String, dynamic> decodedResponse = jsonDecode(response.body);

      for (var e in decodedResponse['results']) {
        movieList.add(Result.fromJson(e));
      }
      movieList.refresh();
    } else {
      throw Exception('Failed to load movies list');
    }
  }

  RxBool isLoading = false.obs;
  Future<void> fetchMovies() async {
    hasMovies.value = true;
    hasPopularMovies.value = true;
    hasUpcomingMovies.value = true;
    hasTopMovies.value = true;

    isLoading.value = true;

    getMovies(pageNumber).catchError((_) {
      hasMovies.value = false;
    });

    await getMoviesByCategories(
      page: pageNumber,
      category: 'popular',
      movieList: popularMoviesList,
    ).catchError((_) {
      hasPopularMovies.value = false;
    });

    await getMoviesByCategories(
      page: 2,
      category: 'upcoming',
      movieList: upcomingMoviesList,
    ).catchError((_) {
      hasUpcomingMovies.value = false;
    });

    await getMoviesByCategories(
      page: pageNumber,
      category: 'top_rated',
      movieList: topRatedMoviesList,
    ).catchError((_) {
      hasTopMovies.value = false;
    });

    await Future.delayed(const Duration(seconds: 1));
    isLoading.value = false;
  }

  @override
  void onInit() {
    super.onInit();
    fetchMovies();
  }
}
