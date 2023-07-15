import 'dart:convert';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../data/models/genre_model.dart';
import '../../../utils/api_key.dart';
import 'package:http/http.dart';

class DetailsController extends GetxController {
  //TODO: Implement DetailsController

  RxBool isLoading = true.obs;
  RxList<GenreElement> genres = <GenreElement>[].obs;

  Future<List<GenreElement>> fetchGenres() async {
    isLoading = false.obs;
    final response = await get(Uri.parse('https://api.themoviedb.org/3/genre/movie/list?api_key=$apiKey'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final List<dynamic> genresData = responseData['genres'];

      genres = genresData.map((json) => GenreElement.fromJson(json)).toList().obs;


      // List<String> genreNames = genres
      //     .where((genre) => genreKeys.contains(genre.id))
      //     .map((genre) => genre.name)
      //     .toList();

      return genresData.map((json) => GenreElement.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch genres');
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchGenres();
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
