import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:movies_details/app/utils/colors.dart';
import 'package:movies_details/app/widgets/custom_network_image.dart';

import '../../../data/models/cast_model.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/custom_divider.dart';
import '../controllers/details_controller.dart';

class DetailsView extends GetView<DetailsController> {
  final String? movieName, overview, backdropImagePath, releaseDate;
  final double? voteAvg;
  final int? voteCount;
  final List<String>? genreNames;
  final RxList<Cast>? castList;

  const DetailsView({
    this.movieName,
    this.overview,
    this.backdropImagePath,
    this.releaseDate,
    this.voteAvg,
    this.voteCount,
    this.genreNames,
    this.castList,
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
                        // const CustomDivider(),
                        // Text('Director'),
                        // const CustomDivider(),
                        // Text('Writers'),
                        const CustomDivider(),
                        const Text('Actor(s)',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        )
                      ]
                    )
                  ),
                ),
                Obx(()=>
                    SliverGrid(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 0.75
                      ),
                      delegate: SliverChildBuilderDelegate(
                            (context, index) {
                          return CustomCard(
                            image: 'https://image.tmdb.org/t/p/original${castList![index].profilePath}',
                            title: '${castList![index].name}',
                            subTitle: '${castList![index].character}',
                          );
                        },
                        childCount: castList!.length <= 10 ? castList!.length : 10,
                      ),
                    ),
                )
                // SliverToBoxAdapter(
                //   child: Padding(
                //     padding: const EdgeInsets.all(14.0),
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       mainAxisSize: MainAxisSize.min,
                //       children: [
                //         releaseDataAndRatingRow(
                //           releaseDate!, voteCount!, voteAvg!
                //         ),
                //         const CustomDivider(),
                //         Text('Genre: ${genreNames!.join(', ')}'),
                //         const CustomDivider(),
                //         Text(overview!,
                //           style: const TextStyle(fontSize: 16),
                //           textAlign: TextAlign.justify,
                //         ),
                //         const CustomDivider(),
                //         Text('Director'),
                //         const CustomDivider(),
                //         Text('Writers'),
                //         const CustomDivider(),
                //         SliverList(delegate: SliverChildBuilderDelegate((context, index) {
                //           return Container();
                //         })),
                //         Container(
                //           height: 100,
                //           width: 300,
                //           child: ListView.builder(
                //             shrinkWrap: true,
                //             scrollDirection: Axis.horizontal,
                //             itemCount: 10,
                //             itemBuilder: (context, index) {
                //               return InkWell(
                //                 onTap: () {
                //
                //                 },
                //                 child: CustomCard(
                //                   image: 'dd',
                //                   title: 'Actor Name',
                //                 )
                //               );
                //             },
                //           ),
                //         ),
                //         const CustomDivider(),
                //       ],
                //     ),
                //   ),
                // )
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
