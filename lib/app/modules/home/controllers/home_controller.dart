import 'dart:convert';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart';
import '../../../data/models/movies_model.dart';
import '../../../utils/api_key.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  RxList<Result> moviesList = <Result>[].obs;
  RxBool isLoading = true.obs;

  int pageNumber = 1;

  String baseUrl = 'https://api.themoviedb.org/3/';
  String baseImageUrl = 'https://image.tmdb.org/t/p/original';

  void getMovies(int page) async {
    isLoading = false.obs;
    moviesList.clear();
    String moviesListUrl = '${baseUrl}discover/movie?page=$page&api_key=$apiKey';
    Response response = await get(Uri.parse(moviesListUrl));
    print('page: $page');

    if(response.statusCode == 200) {
      Map<String, dynamic> decodedResponse = jsonDecode(response.body);
      // print(decodedResponse['page']);
      // print(response.body);

      for(var e in decodedResponse['results']) {
        moviesList.add(
            Result.fromJson(e)
        );
      }
      // setState(() {});
      isLoading = false.obs;
      moviesList.refresh();
    }
    else {
      throw Exception('Failed to load movies list');
    }
  }

  @override
  void onInit() {
    super.onInit();
    getMovies(pageNumber);
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
