import 'dart:convert';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import '../data/models/cast_model.dart';
import 'package:http/http.dart';
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
    print(response.statusCode);

    if(response.statusCode == 200) {
      Map<String, dynamic> decodedResponse = jsonDecode(response.body);
      // print(decodedResponse);

      for(var e in decodedResponse['cast']) {
        movieCastsList.add(
            Cast.fromJson(e)
        );
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
    print(response.statusCode);

    if(response.statusCode == 200) {
      Map<String, dynamic> decodedResponse = jsonDecode(response.body);

      for(var e in decodedResponse['crew']) {
        movieCrewsList.add(
            Crew.fromJson(e)
        );
      }

      // List<Map<String, dynamic>> castingValues = decodedResponse['crew']
      //     .where((item) => item['job'] == 'Director')
      //     .toList();

    }
    else {
      throw Exception('Failed to load movie casts');
    }
  }
}