import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/models/movie/movies_model.dart';
import '../../../../routes/app_pages.dart';
import '../../../../services/api_service.dart';
import '../../../../widgets/custom_card_people.dart';
import '../../../../widgets/people_list_widget.dart';
import '../../../../widgets/shimmer_loading/horizontal_listview_shimmer.dart';
import '../../controllers/home_controller.dart';

class MoviesByCategory extends StatefulWidget {
  const MoviesByCategory(
      {super.key, required this.categoryTitle, required this.list});

  final String categoryTitle;
  final RxList<Result> list;

  @override
  State<MoviesByCategory> createState() => _MoviesByCategoryState();
}

class _MoviesByCategoryState extends State<MoviesByCategory> {
  PageController pageController =
      PageController(viewportFraction: Get.width < 700 ? 0.42 : 0.2);

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Visibility(
        visible: widget.list.isNotEmpty,
        replacement:
            const SliverToBoxAdapter(child: HorizontalListViewShimmerLoading()),
        child: PeopleListWidget(
          category: widget.categoryTitle,
          listView: PageView.builder(
            controller: pageController,
            pageSnapping: true,
            padEnds: false,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: widget.list.length,
            itemBuilder: (context, index) {
              Result movie = widget.list[index];

              return CustomCardPeople(
                onTap: () {
                  Get.delete<HomeController>();

                  Get.toNamed(
                    Routes.DETAILS,
                    arguments: movie.id,
                  );
                },
                image: ApiService().imageUrl(movie.posterPath ?? ''),
                title: movie.title.toString().trim(),
                subTitle: movie.voteAverage.toString().trim(),
                subIcon: Icons.star,
              );
            },
          ),
        ),
      ),
    );
  }
}
