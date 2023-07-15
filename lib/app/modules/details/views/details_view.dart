import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:movies_details/app/utils/colors.dart';
import 'package:movies_details/app/widgets/custom_network_image.dart';

import '../../../widgets/custom_divider.dart';
import '../controllers/details_controller.dart';

class DetailsView extends GetView<DetailsController> {
  String? movieName, overview, backdropImagePath, releaseDate;
  double? voteAvg;
  int? voteCount;
  RxList<int>? genreIdList;

  DetailsView({
    this.movieName,
    this.overview,
    this.backdropImagePath,
    this.releaseDate,
    this.voteAvg,
    this.voteCount,
    this.genreIdList,
    Key? key}) : super(key: key);

  DetailsController detailsController = Get.put(DetailsController());

  @override
  Widget build(BuildContext context) {
    String backdropImage = 'https://image.tmdb.org/t/p/original$backdropImagePath';

    // String genreNames = detailsController.genres
    //     .where((genre) => genreIdList.contains(genre.id))
    //     .map((genre) => genre.name)
    //     .toList().join(', ');

    final Rx<String> genreNames = detailsController.genres
        .where((genre) => genreIdList!.contains(genre.id))
        .map((genre) => genre.name)
        .toList().join(', ').obs;

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
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(releaseDate!),
                            Row(
                              children: [
                                Icon(Icons.star, size: 28,),
                                Column(
                                  children: [
                                    Text('$voteAvg/10',
                                      style: const TextStyle(fontWeight: FontWeight.w800),),
                                    Text('$voteCount')
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                        const CustomDivider(),
                        Text('Genre: ${genreNames.value}'),
                        const CustomDivider(),
                        Text(overview!,
                          style: const TextStyle(fontSize: 16),
                          textAlign: TextAlign.justify,
                        ),
                        const CustomDivider(),
                        Text('Director'),
                        const CustomDivider(),
                        Text('Writers'),
                        const CustomDivider(),
                        Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
                        const CustomDivider(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
    );
  }
}
