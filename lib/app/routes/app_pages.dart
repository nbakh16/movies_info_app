import 'package:get/get.dart';

import 'package:movies_details/app/modules/cast_details/bindings/cast_details_binding.dart';
import 'package:movies_details/app/modules/cast_details/views/cast_details_view.dart';

import '../modules/details/bindings/details_binding.dart';
import '../modules/details/views/details_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/home/views/new_home_view.dart';
import '../modules/movie_search/bindings/movie_search_binding.dart';
import '../modules/movie_search/views/movie_search_view.dart';
import '../modules/movies/bindings/movies_binding.dart';
import '../modules/movies/views/movies_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.NEW_HOME;

  static const Transition pageTransition = Transition.downToUp;

  static final routes = [
    GetPage(
        name: _Paths.HOME,
        page: () => HomeView(),
        binding: HomeBinding(),
        transition: pageTransition),
    GetPage(
        name: _Paths.NEW_HOME,
        page: () => NewHomeView(),
        binding: HomeBinding(),
        transition: pageTransition),
    GetPage(
        name: _Paths.DETAILS,
        page: () => DetailsView(),
        binding: DetailsBinding(),
        transition: pageTransition),
    GetPage(
        name: _Paths.MOVIE_SEARCH,
        page: () => MovieSearchView(),
        binding: MovieSearchBinding(),
        transition: pageTransition),
    GetPage(
        name: _Paths.MOVIES,
        page: () => MoviesView(),
        binding: MoviesBinding(),
        transition: pageTransition),
    GetPage(
      name: _Paths.CAST_DETAILS,
      page: () => CastDetailsView(),
      binding: CastDetailsBinding(),
      transition: pageTransition),
  ];
}
