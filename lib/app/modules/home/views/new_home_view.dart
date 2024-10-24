import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/custom_drawer.dart';
import '../controllers/home_controller.dart';
import 'splash_view.dart';
import 'widets/movie_slider.dart';
import 'widets/movies_by_category.dart';

class NewHomeView extends GetView<HomeController> {
  NewHomeView({Key? key}) : super(key: key);

  final HomeController homeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AnimatedSwitcher(
        duration: const Duration(milliseconds: 1250),
        child: homeController.isLoading.value
            ? const SplashView()
            : Scaffold(
                appBar: const CustomAppBar(title: 'Movies'),
                drawer: const SafeArea(child: CustomDrawer()),
                body: Center(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      homeController.fetchMovies();
                    },
                    child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Obx(
                          () => (homeController.hasMovies.value ||
                                  homeController.hasPopularMovies.value ||
                                  homeController.hasUpcomingMovies.value ||
                                  homeController.hasTopMovies.value)
                              ? _moviesList()
                              : _errorLottie(context),
                        )),
                  ),
                ),
              ),
      ),
    );
  }

  Column _moviesList() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Obx(
          () => !homeController.hasMovies.value
              ? const SizedBox()
              : MovieSlider(),
        ),
        CustomScrollView(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          slivers: [
            Obx(
              () => !homeController.hasPopularMovies.value
                  ? const SizedBox()
                  : MoviesByCategory(
                      categoryTitle: 'Popular',
                      list: homeController.popularMoviesList),
            ),
            Obx(
              () => !homeController.hasUpcomingMovies.value
                  ? const SizedBox()
                  : MoviesByCategory(
                      categoryTitle: 'Upcoming',
                      list: homeController.upcomingMoviesList),
            ),
            Obx(
              () => !homeController.hasTopMovies.value
                  ? const SizedBox()
                  : MoviesByCategory(
                      categoryTitle: 'Top Rated (G.0.A.T)',
                      list: homeController.topRatedMoviesList),
            ),
          ],
        )
      ],
    );
  }

  Center _errorLottie(BuildContext context) {
    return Center(
        child: Lottie.asset('assets/lottie/error.json',
            width: MediaQuery.sizeOf(context).width * 0.5, reverse: true));
  }
}
