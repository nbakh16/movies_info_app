import 'dart:convert';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import '../data/models/cast/cast_model.dart';
import 'package:http/http.dart';
import '../data/models/movie/movies_model.dart';
import '../utils/api_key.dart';

class ApiService{
  RxBool isLoading = true.obs;
  String baseUrl = 'https://api.themoviedb.org/3/';
  String baseImageUrl = 'https://image.tmdb.org/t/p/original';

  ///get movie actors list
  RxList<Cast> movieCastsList = <Cast>[].obs;
  void getMovieCasts(int movieId) async {
    isLoading = false.obs;
    movieCastsList.clear();
    String castListByMovieIdUrl = '$baseUrl/movie/$movieId/credits?api_key=$apiKey';

    Response response = await get(Uri.parse(castListByMovieIdUrl));

    if(response.statusCode == 200) {
      Map<String, dynamic> decodedResponse = jsonDecode(response.body);
      // print(decodedResponse);

      for(var e in decodedResponse['cast']) {
        if(e['order'] < 12) {
          movieCastsList.add(
              Cast.fromJson(e)
          );
        }
      }
    }
    else {
      throw Exception('Failed to load movie casts');
    }
  }

  ///get movie crews list
  RxList<Crew> movieCrewsList = <Crew>[].obs;
  void getMovieCrews(int movieId) async {
    isLoading = false.obs;
    movieCrewsList.clear();

    String crewListByMovieIdUrl = '$baseUrl/movie/$movieId/credits?api_key=$apiKey';

    Response response = await get(Uri.parse(crewListByMovieIdUrl));

    if(response.statusCode == 200) {
      Map<String, dynamic> decodedResponse = jsonDecode(response.body);


      //sorting according to job
      List<dynamic> crewMembers = decodedResponse['crew'];
      Map<String, int> jobPriority = {
        'Director': 1,
        'Writer': 2,
        'Producer': 3,
      };
      crewMembers.sort((a, b) {
        int priorityA = jobPriority[a['job']] ?? 999;
        int priorityB = jobPriority[b['job']] ?? 999;
        return priorityA.compareTo(priorityB);
      });

      for(var e in decodedResponse['crew']) {
        if(e['job'] == 'Director' || e['job'] == 'Writer' || e['job'] == 'Producer') {
          movieCrewsList.add(
              Crew.fromJson(e)
          );
        }
      }
    }
    else {
      throw Exception('Failed to load movie casts');
    }
  }

  ///get recommended movies
  RxList<Result> similarMoviesList = <Result>[].obs;
  void getSimilarMovies(int movieId) async {
    similarMoviesList.clear();
    String similarMoviesByMovieIdUrl = '${baseUrl}movie/$movieId/recommendations?api_key=$apiKey';

    Response response = await get(Uri.parse(similarMoviesByMovieIdUrl));

    if(response.statusCode == 200) {
      Map<String, dynamic> decodedResponse = jsonDecode(response.body);
      // print(decodedResponse);

      for(var e in decodedResponse['results']) {
        similarMoviesList.add(
            Result.fromJson(e)
        );
      }
    }
    else {
      throw Exception('Failed to load similar movies');
    }
  }

  ///search by movie name
  RxList<Result> searchedMoviesList = <Result>[].obs;
  void getSearchedMovie(String queryText) async {
    searchedMoviesList.clear();
    String searchedMovieUrl = '${baseUrl}search/movie?api_key=$apiKey&query=$queryText';

    Response response = await get(Uri.parse(searchedMovieUrl));

    if(response.statusCode == 200) {
      Map<String, dynamic> decodedResponse = jsonDecode(response.body);

      for(var e in decodedResponse['results']) {
        searchedMoviesList.add(
            Result.fromJson(e)
        );
      }
      isLoading = false.obs;
    }
    else {
      throw Exception('Failed to load movie search results');
    }
  }

  ///get movies by genre
  RxList<Result> moviesListByGenre = <Result>[].obs;
  void getMoviesListByGenre(int genreID, int pageNumber) async {
    moviesListByGenre.clear();
    String moviesListByGenreUrl = '${baseUrl}discover/movie?api_key=$apiKey&with_genres=$genreID&page=$pageNumber';
    print(moviesListByGenreUrl);

    Response response = await get(Uri.parse(moviesListByGenreUrl));

    if(response.statusCode == 200) {
      Map<String, dynamic> decodedResponse = jsonDecode(response.body);

      for(var e in decodedResponse['results']) {
        moviesListByGenre.add(
            Result.fromJson(e)
        );
      }
      print('${moviesListByGenre[0].title}');
      print('$decodedResponse');
      isLoading = false.obs;
    }
    else {
      throw Exception('Failed to load movies by genre');
    }
  }
}