import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/models/movies_model.dart';
import '../../../../routes/app_pages.dart';
import '../../../../widgets/custom_card_people.dart';
import '../../../../widgets/people_list_widget.dart';
import '../../../../widgets/shimmer_loading/horizontal_listview_shimmer.dart';

class MoviesByCategory extends StatelessWidget {
  const MoviesByCategory({super.key,
    required this.categoryTitle,
    required this.list
  });

  final String categoryTitle;
  final RxList<Result> list;

  @override
  Widget build(BuildContext context) {
    return Obx(()=>
        Visibility(
          visible: list.isNotEmpty,
          replacement: const SliverToBoxAdapter(
            child: HorizontalListViewShimmerLoading()
          ),
          child: PeopleListWidget(
              category: categoryTitle,
              listView: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: list.length,
                  itemBuilder: (context, index){
                    Result movie = list[index];

                    return CustomCardPeople(
                      onTap: () {
                        Get.toNamed(Routes.DETAILS,
                          arguments: movie,
                        );
                      },
                      image: 'https://image.tmdb.org/t/p/original${movie.posterPath}',
                      title: movie.title.toString().trim(),
                      subTitle: movie.voteAverage.toString().trim(),
                      subIcon: Icons.star,
                      // subTitle: '(${crewList![index].job})',
                    );
                  }
              )
          ),
        )
    );
  }
}
