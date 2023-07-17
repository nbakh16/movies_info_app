import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:movies_details/app/utils/colors.dart';
import 'package:movies_details/app/widgets/custom_card_people.dart';
import 'package:movies_details/app/widgets/custom_network_image.dart';

import '../../../data/models/cast_model.dart';
import '../../../widgets/custom_divider.dart';
import '../../../widgets/people_list_widget.dart';
import '../controllers/details_controller.dart';

class DetailsView extends GetView<DetailsController> {
  final String? movieName, overview, backdropImagePath, releaseDate;
  final double? voteAvg;
  final int? voteCount;
  final List<String>? genreNames;
  final RxList<Cast>? castList;
  final RxList<Crew>? crewList;

  const DetailsView({
    this.movieName,
    this.overview,
    this.backdropImagePath,
    this.releaseDate,
    this.voteAvg,
    this.voteCount,
    this.genreNames,
    this.castList,
    this.crewList,
    Key? key}) : super(key: key);

  // DetailsController detailsController = Get.put(DetailsController());

  @override
  Widget build(BuildContext context) {
    String backdropImage = 'https://image.tmdb.org/t/p/original$backdropImagePath';

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            mainColor,
            mainColor,
            mainColor,
            mainColor.shade600,
            mainColor.shade700,
            mainColor.shade800,
            mainColor.shade900
          ]
        )
      ),
      child: Scaffold(
            backgroundColor: Colors.transparent,
            body: CustomScrollView(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  // title: Text('Movie Name'),
                  toolbarHeight: 100,
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(10),
                    child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: mainColor,
                            border: Border(
                                bottom: BorderSide(width: 4, color: mainColor.shade900)
                            )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(movieName!,
                            style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        )
                    ),
                  ),
                  elevation: 0,
                  pinned: true,
                  stretch: true,
                  stretchTriggerOffset: 22,
                  expandedHeight: 300.0,
                  flexibleSpace: FlexibleSpaceBar(
                      stretchModes: const [
                        StretchMode.zoomBackground
                      ],
                      background: CustomNetworkImage(imgUrl: backdropImage,)
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(12.0),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate (
                      [
                        releaseDataAndRatingRow(
                            releaseDate!, voteCount!, voteAvg!
                        ),
                        const CustomDivider(),
                        Text('Genre: ${genreNames!.join(', ')}',
                          style: const TextStyle(fontSize: 18),
                        ),
                        const CustomDivider(),
                        Text(overview!,
                          style: const TextStyle(fontSize: 16),
                          textAlign: TextAlign.justify,
                        ),
                      ]
                    )
                  ),
                ),
                PeopleListWidget(
                  category: 'Cast(s)',
                  obxListView: Obx(()=>
                      ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: castList!.length,
                          itemBuilder: (context, index){
                            return CustomCardPeople(
                              image: 'https://image.tmdb.org/t/p/original${castList![index].profilePath}',
                              title: '${castList![index].name}',
                              subTitle: '${castList![index].character}',
                              // subTitle: '(${crewList![index].job})',
                            );
                          })
                  )
                ),
                PeopleListWidget(
                    category: 'Crew(s)',
                    obxListView: Obx(()=>
                        ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: crewList!.length,
                            itemBuilder: (context, index){
                              return CustomCardPeople(
                                image: 'https://image.tmdb.org/t/p/original${crewList![index].profilePath}',
                                title: '${crewList![index].name}',
                                subTitle: '${crewList![index].job}',
                                // subTitle: '(${crewList![index].job})',
                              );
                            })
                    )
                ),
              ],
            ),
          ),
    );
  }

  Row releaseDataAndRatingRow(
      String releaseDate, int voteCount, double voteAvg
      ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(releaseDate.toString()),
        Row(
          children: [
            const Icon(Icons.star, size: 26,),
            Column(
              children: [
                Text('$voteAvg/10',
                  style: const TextStyle(fontWeight: FontWeight.w900),),
                Text(voteCount.toString(),
                  style: const TextStyle(fontWeight: FontWeight.w400),)
              ],
            )
          ],
        )
      ],
    );
  }
}
