import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'package:get/get.dart';
import 'package:movies_details/app/modules/details/controllers/details_controller.dart';
import 'package:movies_details/app/widgets/custom_divider.dart';
import 'package:movies_details/app/widgets/label_and_text.dart';

import '../../../data/models/cast/cast_bio_model.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/colors.dart';
import '../../../widgets/circular_icon_btn.dart';
import '../../../widgets/custom_card_people.dart';
import '../../../widgets/custom_dialog.dart';
import '../../../widgets/custom_network_image.dart';
import '../../../widgets/people_list_widget.dart';
import '../controllers/cast_details_controller.dart';
import 'package:expandable_text/expandable_text.dart';

class CastDetailsView extends GetView<CastDetailsController> {
  CastDetailsView({super.key});
  final CastDetailsController castDetailsController = Get.find();

  @override
  Widget build(BuildContext context) {
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
          ])),
      child: SafeArea(
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Obx(() {
                if (castDetailsController.castInfo.value == null) {
                  return const CircularProgressIndicator();
                } else if (castDetailsController.castInfo.value == CastBio()) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'No Data found!',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: Colors.yellowAccent),
                      ),
                    ),
                  );
                } else {
                  final castInfo = castDetailsController.castInfo.value;
                  String castImage(String path) =>
                      'https://image.tmdb.org/t/p/original$path';

                  return CustomScrollView(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      SliverAppBar(
                        pinned: true,
                        stretch: true,
                        stretchTriggerOffset: 20,
                        expandedHeight: 450.0,
                        toolbarHeight: 110.0,
                        elevation: 12,
                        leading: IconButton(
                          icon: const Icon(IconlyLight.arrowLeft2, size: 35),
                          onPressed: () => Get.back(),
                        ),
                        flexibleSpace: InkWell(
                          onTap: castInfo?.profilePath == ''
                              ? null
                              : () {
                                  imageViewDialog(
                                    context: context,
                                    imageProvider: CachedNetworkImageProvider(
                                        castImage(castInfo?.profilePath ?? '')),
                                  );
                                },
                          child: Center(
                            child: CustomNetworkImage(
                              imgUrl: castImage(castInfo?.profilePath ??
                                  Icons.image.toString()),
                            ),
                          ),
                        ),
                        bottom: PreferredSize(
                          preferredSize: const Size.fromHeight(60),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  castInfo?.homepage == null
                                      ? const SizedBox()
                                      : CircularIconButton(
                                          onTap: () {
                                            Get.toNamed(Routes.WEB_VIEW,
                                                arguments: castInfo?.homepage);
                                          },
                                          icon: const Icon(Icons.link),
                                        )
                                ],
                              ),
                              Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0, vertical: 8.0),
                                  decoration: BoxDecoration(
                                    color: mainColor.withOpacity(0.85),
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(16),
                                      topLeft: Radius.circular(16),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      castInfo?.name ?? '',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Visibility(
                          visible: castInfo!.birthday != null &&
                              castInfo.biography != "",
                          replacement: Center(
                              child: Text(
                            'Not enough data to show!',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(color: Colors.yellowAccent),
                          )),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                castInfo.birthday == null
                                    ? const SizedBox()
                                    : LabelAndText(
                                        label: 'Born',
                                        text: castInfo.birthday.toString()),
                                castInfo.placeOfBirth == null
                                    ? const SizedBox()
                                    : LabelAndText(
                                        label: 'Place of Birth',
                                        text: castInfo.placeOfBirth.toString()),
                                const SizedBox(
                                  height: 6.0,
                                ),
                                castInfo.deathday == null
                                    ? const SizedBox()
                                    : LabelAndText(
                                        label: 'Died',
                                        text: castInfo.deathday.toString()),
                                const CustomDivider(),
                                Text(
                                  'Biography',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                const SizedBox(
                                  height: 6.0,
                                ),
                                ExpandableText('${castInfo.biography}',
                                    expandText: 'show more',
                                    collapseText: 'show less',
                                    maxLines: 5,
                                    linkColor: Colors.yellowAccent,
                                    animation: true,
                                    animationDuration:
                                        const Duration(seconds: 2),
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                    textAlign: TextAlign.justify,
                                    linkStyle:
                                        Theme.of(context).textTheme.bodyLarge),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Obx(() => Visibility(
                            visible:
                                castDetailsController.castMoviesList.isNotEmpty,
                            replacement: const SliverToBoxAdapter(),
                            child: PeopleListWidget(
                                category: 'Known For',
                                listView: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: castDetailsController
                                        .castMoviesList.length,
                                    itemBuilder: (context, index) {
                                      final movies = castDetailsController
                                          .castMoviesList[index];
                                      return CustomCardPeople(
                                        onTap: () {
                                          Get.delete<DetailsController>();

                                          Get.toNamed(
                                            Routes.DETAILS,
                                            arguments: movies.id,
                                          );

                                          Get.delete<CastDetailsController>();
                                        },
                                        image:
                                            'https://image.tmdb.org/t/p/original${movies.posterPath}',
                                        title: movies.title.toString().trim(),
                                        subTitle: movies.voteAverage
                                            .toString()
                                            .trim(),
                                        subIcon: Icons.star,
                                      );
                                    })),
                          )),
                    ],
                  );
                }
              }),
            )),
      ),
    );
  }
}
