import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:movies_details/app/data/models/genre_model.dart';
import 'package:movies_details/app/utils/colors.dart';
import 'package:movies_details/app/widgets/custom_card_people.dart';
import 'package:movies_details/app/widgets/custom_network_image.dart';
import 'package:movies_details/app/widgets/cutom_button.dart';

import '../../../data/models/cast_model.dart';
import '../../../data/models/movies_model.dart';
import '../../../widgets/custom_divider.dart';
import '../../../widgets/people_list_widget.dart';
import '../controllers/details_controller.dart';

class DetailsView extends GetView<DetailsController> {
  final String? movieName, overview, backdropImagePath, releaseDate;
  final double? voteAvg;
  final int? voteCount;
  final List<GenreElement>? movieGenre;
  final RxList<Cast>? castList;
  final RxList<Crew>? crewList;
  final RxList<Result>? similarMoviesList;

  const DetailsView({
    this.movieName,
    this.overview,
    this.backdropImagePath,
    this.releaseDate,
    this.voteAvg,
    this.voteCount,
    this.movieGenre,
    this.castList,
    this.crewList,
    this.similarMoviesList,
    Key? key}) : super(key: key);

  // DetailsController detailsController = Get.put(DetailsController());

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
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
                        GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount: movieGenre!.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: screenWidth<700 ? 3 : screenWidth<900 ? 4 : 5,
                            mainAxisExtent: 50,
                            crossAxisSpacing: 3.0,
                            mainAxisSpacing: 3.0,
                          ),
                          itemBuilder: (context, index) {
                            return Center(
                              child: CustomButton(
                                onTap: (){
                                  print('${movieGenre![index].id} <> ${movieGenre![index].name}');
                                  // TODO: api call to get movies according to genre
                                },
                                btnText: movieGenre![index].name,
                              ),
                            );
                          }
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
                    category: 'Related Movies',
                    obxListView: Obx(()=>
                        ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: similarMoviesList!.length,
                            itemBuilder: (context, index){
                              return CustomCardPeople(
                                image: 'https://image.tmdb.org/t/p/original${similarMoviesList![index].posterPath}',
                                title: similarMoviesList![index].originalTitle.toString(),
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
